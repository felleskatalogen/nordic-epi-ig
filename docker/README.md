# Example styling for the ePIs

1. Use `docker-compose.yml` to start Nginx.
1. Open `http://localhost/examples/` in a web browser
1. Click on any of the FHIR XML ePIL Bundle files, e.g. http://localhost/examples/Bundle-Level-1-Norwegian.xml

Relative to the `docker` directory, `../input/examples` is mapped to `/examples` on the server.
`nginx.conf` loads the XSLT filter module in Nginx.
The `/` location is configured in `default.conf` to apply `stylesheet-pi.xsl` on the XML files before sending them to the client.
This stylesheet adds a processing instruction to the XMLs that instructs the client (the browser) to apply the transformation in `fk-epi/fk-epi-bootstrap.xsl` when the XML response from the server is displayed.

The result in the browser is an HTML view that can demonstrate how the FHIR ePI can be displayed to the user, in this case using [Bootstrap](https://getbootstrap.com/docs/5.3/getting-started/introduction/) components. The view source function will show the original FHIR XML, with the processing instruction added by Nginx.

Note: this is for demonstration purposes only. According to [the relevant section of the FHIR specification](https://hl7.org/fhir/R5/xml.html), "XML comments, processing instructions and formatting are not part of the contents of a resource", and "Other processing instructions [other that the XML declaration] SHOULD not be included and SHALL NOT be required to properly understand and/or present the data or narrative of the resource. Applications MAY preserve processing instructions when handling resources, but are not required to do so".
