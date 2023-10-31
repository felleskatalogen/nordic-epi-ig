Profiles define additional requirements that the resources must satisfy for the purpose of this implementation. For general information on profiling, see [the Profiling page](http://hl7.org/fhir/R5/profiling.html) of the FHIR specification. Profiles in this implementation guide extend those defined by the [Electronic Medicinal Product Information (ePI) FHIR Implementation Guide](http://hl7.org/fhir/uv/emedicinal-product-info/).

### The ePI documents

In the Nordic countries, the structure of package leaflets follows the QRD template from EMA.

TODO: link to a general discussion of the template on EMA's website
TODO: country-specific details, if necessary, with links to exact template versions or national guidelines

In terms of FHIR resources, the actual text of the ePI document in contained in Composition resources. The document structure is therefore defined as a profile on the Composition resource: [Composition for Nordic ePI PIL](StructureDefinition-Nordic-ePI-Composition-PIL.html).

The profile translates the QRD template to a hierarchy of sections, and binds the sections to specific codes: codes from SPOR if they are available, or custom codes created by the Nordic ePI project if necessary (link to both value sets).

The composition is packaged into a Bundle resource, together with the structured medication resources it refers to, to form a FHIR document.

TODO: Visual representation of the resources that make up the ePI Bundle, and their relations.

### Medicinal product definitions

The documents refer to medicinal products as their subject. These medicinal products are defined by MedicinalProductDefinition and PackagedProductDefinition resources.

These resources carry the identifiers that can be used to look up the ePIs.

#### MedicinalProductDefinition

MedicinalProductDefinition is: TODO: non-technical definition

Profile: [PackagedProductDefinition for Nordic ePI](StructureDefinition-Nordic-ePI-MedicinalProductDefinition.html)

The identifiers:

* Denmark: TODO
* Finland: TODO
* Norway: `http://legemiddelverket.no/FEST/LegemiddelMerkevareID`
* Sweden: TODO

#### PackagedProductDefinition

PackagedProductDefinition is: TODO: non-technical definition

Profile: [PackagedProductDefinition for Nordic ePI](StructureDefinition-Nordic-ePI-PackagedProductDefinition.html)

* National IDs:
  * Denmark: TODO
  * Finland: TODO
  * Norway: `http://legemiddelverket.no/FEST/LegemiddelPakningID`
  * Sweden: TODO
* Nordic Article Numbers (country specific definition)
  * Denmark: TODO
  * Finland: TODO
  * Norway: `https://farmalogg.no/varenummer`
  * Sweden: TODO
