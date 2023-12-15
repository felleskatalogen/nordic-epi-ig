flowchart LR

subgraph sg1 [Bundle]
  direction LR

  C(Composition)
  MPD(MedicinalProductDefinition)
  PPD(PackagedProductDefinition)

  C -->|".subject"| MPD
  PPD -->|".packageFor"| MPD

  end
