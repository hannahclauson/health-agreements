General / rails questions:

- generally do you always add migrations on top?
- Im in a situation where I've created:
  - company / guideline / practice
  - but now it seems tricky to add new associations / polymorphism when I add archetype and badge models
  - I'm sure there is a way forward by adding new migrations
  - but since im only dealing w seed data ... wouldnt it be easier to blow away all migrations, write them so that all of the has_* objects are created first, then create the belongs_to objects w the polymorphism in place?
- migration was easy enough..

# Now I have practices use :practiceable to access parent company/archetype. Aaand i now have badge which also belongs to each of those company/arch. Should that be an interface as well? If so, should I reuse the practiceable interface or define a new association?