from fastapi import FastAPI, HTTPException, status
from pydantic import BaseModel

class ShipmentIn(BaseModel):
    carrier: str
    delay_days: int

app = FastAPI()
shipments_db: dict[str, ShipmentIn] = {}

def compute_status(delay_days: int) -> str:
    # YOUR CODE HERE: return 'on_time', 'minor_delay', or 'major_delay'
    # based on delay_days (0 = on_time, 1-2 = minor_delay, 3+ = major_delay)
    if delay_days < 0:
        raise ValueError("delay cannot be less than 0!")
    if delay_days == 0:
        return 'on_time'
    if delay_days <= 2:
        return 'minor_delay'
    return 'major_delay'

class Shipment:
    def __init__(self, shipment_id: str, carrier: str, delay_days: int) -> None:
        # YOUR CODE HERE: store the three fields as attributes
        self.shipment_id: str = shipment_id
        self.carrier:     str = carrier
        self.delay_days:  int = delay_days

    def status(self) -> str:
        # YOUR CODE HERE: use compute_status
        return compute_status(self.delay_days)

@app.get("/shipments/{shipment_id}")
def get_shipment(shipment_id: str) -> ShipmentIn:
    # YOUR CODE HERE: return the shipment, or raise HTTPException(404)
    # if shipment_id isn't in shipments_db
    if not (shipment_id in shipments_db):
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail=f"item with shipment id {shipment_id} was not found!"
        )
    return shipments_db[shipment_id]

@app.post("/shipments/{shipment_id}")
def create_shipment(shipment_id: str, shipment: ShipmentIn) -> ShipmentIn:
    # YOUR CODE HERE: store the shipment and return it, including
    # its computed status
    shipments_db[shipment_id] = shipment
    return shipments_db[shipment_id]
