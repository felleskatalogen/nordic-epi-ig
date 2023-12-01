Profiles define additional requirements that the resources must satisfy for the purpose of this implementation. For general information on profiling, see [the Profiling page](http://hl7.org/fhir/R5/profiling.html) of the FHIR specification. Profiles in this implementation guide extend those defined by the [Electronic Medicinal Product Information (ePI) FHIR Implementation Guide](http://hl7.org/fhir/uv/emedicinal-product-info/).

### The ePI documents

#### Bundle

A FHIR document is implemented as a Bundle resource with type 'document', with a Composition as the first item. The Bundle can include the structured medication resources that the Composition refers to.

TODO: Visual representation of the resources that make up the ePI Bundle, and their relations.

#### Composition

In the Nordic countries, the structure of package leaflets follows the QRD template from EMA.

TODO: link to a general discussion of the template on EMA's website
TODO: country-specific details, if necessary, with links to exact template versions or national guidelines

In terms of FHIR resources, the actual text of the documents is contained in Composition resources. The document structure is therefore defined as a profile on the Composition resource: [Composition for Nordic ePI PIL](StructureDefinition-Nordic-ePI-Composition-PIL.html).

The profile translates the QRD template to a hierarchy of sections, and binds the sections to specific codes: codes from SPOR if they are available, or custom codes created by the Nordic ePI project if necessary.

These code types are defined in separate CodeSystem resources:

* Codes from SPOR RMS:
  * [Document types](CodeSystem-EmaRmsDocTypes.html)
  * [Section codes (SPOR)](CodeSystem-EmaRmsQrd.html)
* Custom codes:
  * [Section codes (Gravitate Health)](CodeSystem-GhEpiSections.html)

### Medicinal product definitions

Structured information about the medicinal products is included in the ePI Bundle as MedicinalProductDefinition and PackagedProductDefinition resources. Each Composition refers to one or more MedicinalProductDefinition resources from the .subject field. Each PackagedProductDefinition resource refers to a single MedicinalProductDefinition from the .packageFor field.

The implementation guide defines profiles for both MedicinalProductDefinition and PackagedProductDefinition to specify project- or region-specific properties, such as the national identifiers that are assigned to products and packages in the Nordic countries.

#### MedicinalProductDefinition

The MedicinalProductDefinition resource represents a medicinal product with a single set of ingredients and physical form and strength.

The [MedicinalProductDefinition for Nordic ePI](StructureDefinition-Nordic-ePI-MedicinalProductDefinition.html) profile defines the following national identifiers:

* Denmark: TODO
* Finland: TODO
* Norway: `http://legemiddelverket.no/FEST/LegemiddelMerkevareID`
* Sweden: TODO

#### PackagedProductDefinition

The PackagedProductDefinition resource represents a package of a medicinal product as it has been prepared for sale.

The [PackagedProductDefinition for Nordic ePI](StructureDefinition-Nordic-ePI-PackagedProductDefinition.html) profile defines the following national identifiers:

* National IDs:
  * Denmark: TODO
  * Finland: TODO
  * Norway: `http://legemiddelverket.no/FEST/LegemiddelPakningID`
  * Sweden: TODO
* Nordic Article Numbers (country-specific definition)
  * Denmark: TODO
  * Finland: `https://pharmaca.fi/vnr`
  * Norway: `https://farmalogg.no/varenummer`
  * Sweden: TODO
