## Day 2

### Exercise 1 - Track A
* Completed New Joiner Level Track. Can't fully do Trainee level task yet.

#### Reflection Questions

**New joiners: which part of the API was hardest — the Python logic, or getting
the HTTP status codes right? What does that tell you about where to focus
next?**

Neither, in my opinion. The hard part, as far as I see it, was to ensure that
the architecture made sense and was intuitive and easy to maintain. As an
example, consider this code snippet:

```python
@app.post("/shipments/{shipment_id}")
def create_shipment(shipment_id: str, shipment: ShipmentIn):
    # YOUR CODE HERE: store the shipment and return it, including
    # its computed status
```

The question became "What should the returned object be? A tuple like `shipment,
compute_status(shipment.shipment_id)`? Or maybe the `ShipmentIn` object itself
should store the status?"

**Both: how does today's compute_status function relate to the AI decision
framework from Phase 1 — is this a case where simple rules-based logic is
clearly the right choice over an ML or GenAI approach?**

Yes. Since the rules for what is a on-time shipment, a minor-delay shipment, and
a major-delay shipment are already known, a straightforward and deterministic
function is good here.

### Exercise 2

#### Reflection Questions

**Which query took longest to get right, and was the issue the JOIN condition or
the GROUP BY logic?**

It was the last one:

```sql
-- YOUR QUERY: which supplier's shipments have the highest average
-- delay? (requires joining AND aggregating together)
```

The difficulty was that this needed several joins stacked on top of a `group by`
clause.

**Study Material Section 6 says a JOIN and an Ontology link perform 'the same
operation.' After writing these queries by hand, does that claim feel true or
overstated?**

I don't know as I don't know how Ontology works. But I hope to answer this soon.

**If you had to explain Task 2's two-table join to someone who's never written
SQL, what's the one-sentence explanation you'd use?**

"Find the PO ID correlating to each shipment, then find the supplier ID
correlating to that PO ID, then find the supplier name of the respective ID."
