# Nordic ePI Implementation Guide

This is the repository of the Nordic ePI Implementation Guide.

The result of the latest successful build is available on [https://build.fhir.org/ig/felleskatalogen/nordic-epi-ig/](https://build.fhir.org/ig/felleskatalogen/nordic-epi-ig/)

## Prerequisites

The IG Publisher needs the following to be installed:

   * Java 11 or later
   * Ruby
   * The Jekyll gem

## Build instructions

1. Run `_updatePublisher.sh` to update the scripts locally and download the IG Publisher JAR
1. Run `_genonce.sh` to build the implementation guides

Check the output for any errors. 

If the build is successful, open `output/index.html` in a browser, this is the entry page of the implementation guide.

See also [the IG Publisher documentation](https://confluence.hl7.org/display/FHIR/IG+Publisher+Documentation).
