For general information on profiling, see the [Profiling FHIR](http://hl7.org/fhir/R5/profiling.html) page of the FHIR specification.

Profiles in this implementation guide extend those defined by the [Electronic Medicinal Product Information (ePI) FHIR Implementation Guide](http://hl7.org/fhir/uv/emedicinal-product-info/).

The implementation guide defines profiles for Composition, MedicinalProductDefinition and PackagedProductDefinition to specify project- or region-specific properties, such as the national identifiers that are assigned to products and packages in the Nordic countries.

### Bundle

A FHIR document is implemented as a Bundle resource with type `document` and a Composition as the first entry. The Bundle can also include the resources that the Composition refers to.

This implementation guide uses the Bundle definition from the Electronic Medicinal Product Information (ePI) FHIR Implementation Guide directly and does not define any additional restrictions for Bundles.

The ePI Bundle is the container of the resources that make up a FHIR ePI. The following graph illustrates the ePI Bundle components that are used in this implementation guide and their relations:

<img src="bundle-components.png" alt="Components and relations in an ePI Bundle" style="float: none;"/>

See the [ePI Creation](https://hl7.org/fhir/uv/emedicinal-product-info/STU1/steps-to-create-epi3.html) pages in the Electronic Medicinal Product Information (ePI) FHIR Implementation Guide for a more comprehensive graph showing more structured resources that can be used to represent details about an ePI.

### Composition

In terms of FHIR resources, the actual text of a package leaflet is contained in a Composition resource. The document structure is therefore defined as a profile on the Composition resource: [Composition for Nordic ePI PIL](StructureDefinition-Nordic-ePI-Composition-PIL.html).

In the Nordic countries, the structure of package leaflets follows the QRD template from EMA.
* TODO: link to a general discussion of the template on EMA's website
* TODO: country-specific details, if necessary, with links to exact template versions or national guidelines

The Composition profile translates the QRD template to a hierarchy of sections, and binds the sections to specific codes, either from SPOR, if they are available, or custom codes created by the Nordic ePI project if necessary.

These codes are defined in separate CodeSystem resources:

* [Section codes (SPOR)](CodeSystem-EmaRmsQrd.html)
* [Section codes (Gravitate Health)](CodeSystem-GhEpiSections.html)

The composition is identified as a package leaflet using a code from SPOR. This code is defined in its own code system:

* [Document types](CodeSystem-EmaRmsDocTypes.html)

### MedicinalProductDefinition

The MedicinalProductDefinition resource (MPD) represents a branded medicinal product with a single set of ingredients and a specific pharmaceutical dose form and strength.

The corresponding entity in the national master data files is:

* Denmark: TODO DrugId?
* Finland: TODO (Laakevalmiste?) ([Basic register](https://fimea.fi/en/databases_and_registers/basic-register-xml))
* Norway: LegemiddelMerkevare ([FEST (Forskrivnings- og ekspedisjonsstøtte)](https://www.dmp.no/om-oss/distribusjon-av-legemiddeldata/fest))
* Sweden: medprod.nplid ([NPL (Nationellt produktregister för läkemedel, NPL)](https://www.lakemedelsverket.se/sv/e-tjanster-och-hjalpmedel/substans-och-produktregister/npl))

Each Composition can refer to one or more MedicinalProductDefinition resources from the `.subject` field.

The [MedicinalProductDefinition for Nordic ePI](StructureDefinition-Nordic-ePI-MedicinalProductDefinition.html) profile defines the following national identifiers:

* Denmark: `https://www.indlaegssedler.dk/Indlaegssedler/Indlaegsseddel/`
* Finland: TODO
* Norway: `http://legemiddelverket.no/FEST/LegemiddelMerkevareID`
* Sweden: `http://electronichealth.se/fhir/NamingSystem/nplid`

### PackagedProductDefinition

The PackagedProductDefinition resource (PPD) represents a package of a medicinal product as it has been prepared for sale.

Each PackagedProductDefinition resource refers to a single MedicinalProductDefinition from the `.packageFor` field. Several PackagedProductDefinition resources can refer to the same MedicinalProductDefinition (e.g. different package sizes of the same product).

The [PackagedProductDefinition for Nordic ePI](StructureDefinition-Nordic-ePI-PackagedProductDefinition.html) profile defines the following national identifiers:

* National IDs:
  * Denmark: TODO
  * Finland: TODO
  * Norway: `http://legemiddelverket.no/FEST/LegemiddelPakningID`
  * Sweden: `http://electronichealth.se/fhir/NamingSystem/nplpackid`
* Nordic Article Numbers (country-specific definition):
  * Denmark: `https://www.indlaegssedler.dk/varenummer`
  * Finland: `https://pharmaca.fi/vnr`
  * Norway: `https://farmalogg.no/varenummer`
  * Sweden: `http://electronichealth.se/fhir/NamingSystem/varunr`
