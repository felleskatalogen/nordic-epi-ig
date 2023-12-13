For general information on code systems, see the [Terminology Module](http://hl7.org/fhir/R5/terminology-module.html) in the FHIR specification.

This implementation guide uses coded values to identify the document as a Package Leaflet, and to identify the individual sections within the document.

### Document types

Codes for document types (including only one in-scope code) are defined in the code system [Product Information Document Type](CodeSystem-EmaRmsDocTypes.html).

### Sections

Codes from EMA's [SPOR](https://spor.ema.europa.eu/sporwi) RMS are used whenever possible to identify sections. These codes are defined as a FHIR code system in [Quality Review of Documents Product Information Template](CodeSystem-EmaRmsQrd.html) as part of this implementation guide to facilitate validation of the example resources.

Custom codes are used for sections that do not have an appropriate code defined in SPOR RMS. These additional section codes are defined in [GH ePI sections](CodeSystem-GhEpiSections.html).

Example: a code is defined for the Table of Contents. Applications might choose to suppress the original Table of Contents and generate a new one with active links, using the section and subsection structure of the document.
