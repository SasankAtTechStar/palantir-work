/*

We have the below tables

CREATE TABLE suppliers (
    supplier_id TEXT PRIMARY KEY,
    supplier_name TEXT,
    region TEXT
);

CREATE TABLE purchase_orders (
    po_id TEXT PRIMARY KEY,
    supplier_id TEXT,
    order_date TEXT,
    po_number TEXT
);

CREATE TABLE shipments (
    shipment_id TEXT PRIMARY KEY,
    po_id TEXT,
    carrier TEXT,
    delay_days INTEGER

);

*/

-- YOUR QUERY: find all shipments with delay_days greater than 2

select
    *
from shipments
where delay_days > 2;

-- YOUR QUERY: find all shipments carried by 'FastFreight'

select
    *
from shipments
where carrier = 'FastFreight';

-- YOUR QUERY: for every shipment, show the shipment_id, carrier,
-- and the name of the supplier whose PO it belongs to
-- (join shipments -> purchase_orders -> suppliers)

select
    sm.shipment_id,
    sm.carrier,
    po.po_id,
    sp.supplier_name
from shipments sm
inner join purchase_orders po
    on sm.po_id = po.po_id
inner join suppliers sp
    on po.supplier_id = sp.supplier_id;

-- YOUR QUERY: average delay_days and total shipment count per
-- carrier, ordered from worst average delay to best

select
    carrier,
    avg(delay_days),
    count(shipment_id)
from shipments
group by carrier
order by avg(delay_days) desc;

-- YOUR QUERY: which supplier's shipments have the highest average
-- delay? (requires joining AND aggregating together)

select
    sp.supplier_name,
    avg(sm.delay_days)
from shipments sm
inner join purchase_orders po
    on sm.po_id = po.po_id
inner join suppliers sp
    on po.supplier_id = sp.supplier_id
group by sp.supplier_name
order by avg(sm.delay_days) desc
limit 1;
