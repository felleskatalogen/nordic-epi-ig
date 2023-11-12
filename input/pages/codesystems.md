For general information on code systems, see [the Terminology Module](http://hl7.org/fhir/R5/terminology-module.html) in the FHIR specification.

This implementation guide uses coded values to identify the document as a Package Leaflet, and to identify the individual sections within the document.

Codes from [SPOR](https://spor.ema.europa.eu/sporwi) RMS are used whenever possible, custom codes are only defined (in a separate code system) when an appropriate code is not available in SPOR.

TODO: examples for additional sections that need to be identified for highlight/suppress functionality.

### Document types

Codes for document types (including only one in-scope code) are defined in [Product Information Document Type](CodeSystem-EmaRmsDocTypes.html).

#### Sections

The [Quality Review of Documents Product Information Template](CodeSystem-EmaRmsQrd.html) code system is created to represent section codes that are defined in SPOR. Custom codes for additional sections are defined in [GH ePI sections](CodeSystem-GhEpiSections.html).
