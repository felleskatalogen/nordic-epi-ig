<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:fhir="http://hl7.org/fhir" xmlns:html="http://www.w3.org/1999/xhtml"
    exclude-result-prefixes="xs fhir html" version="3.0">

    <xsl:output indent="yes"/>

    <xsl:variable name="emaQrdSystem" select="'https://spor.ema.europa.eu/v1/lists/200000029659/terms/'"/>



    <!-- Composition.title from product name -->

    <xsl:template match="fhir:Composition/fhir:title">
        <title xmlns="http://hl7.org/fhir">
            <xsl:attribute name="value">
                <xsl:variable name="mpdRef" select="../fhir:subject/fhir:reference/@value"/>
                <xsl:variable name="mpdId" select="substring-after($mpdRef, '/')"/>
                <xsl:variable name="mpd" select="/fhir:Bundle/fhir:entry/fhir:resource/fhir:MedicinalProductDefinition[fhir:id/@value = $mpdId]" as="node()*"/>
                <xsl:value-of select="$mpd/fhir:name/fhir:part[fhir:type/fhir:text/@value = 'tradename']/fhir:part/@value"/>
                <xsl:text> </xsl:text>
                <xsl:value-of select="$mpd/fhir:name/fhir:part[fhir:type/fhir:text/@value = 'strength-num']/fhir:part/@value"/>
                <xsl:text> </xsl:text>
                <xsl:value-of select="$mpd/fhir:name/fhir:part[fhir:type/fhir:text/@value = 'strength-unit']/fhir:part/@value"/>
                <xsl:text> </xsl:text>
                <xsl:value-of select="$mpd/fhir:name/fhir:part[fhir:type/fhir:text/@value = 'pharmform']/fhir:part/@value"/>
            </xsl:attribute>
        </title>
    </xsl:template>



    <!-- Section 2 subsection 'Excipient(s) with known effect' -->

    <xsl:template match="fhir:section[fhir:code/fhir:coding[fhir:system/@value = $emaQrdSystem and fhir:code/@value = '200000029796']]/fhir:text/html:div">
        <xsl:variable name="mpdRef" select="../../../../../fhir:subject/fhir:reference/@value"/>
        <xsl:variable name="ingredients" select="/fhir:Bundle/fhir:entry/fhir:resource/fhir:Ingredient[fhir:role/fhir:coding[fhir:system/@value = 'https://spor.ema.europa.eu/v1/lists/100000072050/terms/' and fhir:code/@value = '100000072082'] and fhir:for/fhir:reference/@value = $mpdRef]" as="node()*"/>
        <!-- TODO Check substance code against the known Excipient List -->
        <xsl:copy>
            <xsl:apply-templates/>
            <div xmlns="http://www.w3.org/1999/xhtml">
                <xsl:apply-templates select="$ingredients" mode="section23"/>
            </div>
            <div xmlns="http://www.w3.org/1999/xhtml">
                <p>For the full list of excipients, see section 6.1.</p>
            </div>
        </xsl:copy>
    </xsl:template>

    <xsl:template match="fhir:Ingredient" mode="section23">
        <xsl:variable name="substRef" select="fhir:substance/fhir:code/fhir:reference/fhir:reference/@value"/>
        <xsl:variable name="substId" select="substring-after($substRef, '/')"/>
        <xsl:variable name="substanceDefinitions" select="/fhir:Bundle/fhir:entry/fhir:resource/fhir:SubstanceDefinition[fhir:id/@value = $substId]" as="node()*"/>
        <p xmlns="http://www.w3.org/1999/xhtml" class="ingredient">
            <xsl:text>Contains </xsl:text>
            <xsl:value-of select="fhir:substance/fhir:strength/fhir:presentationQuantity/fhir:value/@value"/>
            <xsl:text> </xsl:text>
            <xsl:value-of select="fhir:substance/fhir:strength/fhir:presentationQuantity/fhir:unit/@value"/>
            <xsl:text> </xsl:text>
            <xsl:apply-templates select="$substanceDefinitions" mode="section23"/>
        </p>
    </xsl:template>

    <xsl:template match="fhir:SubstanceDefinition" mode="section23">
        <span xmlns="http://www.w3.org/1999/xhtml">
            <xsl:attribute name="class">
                <xsl:text>coded-data </xsl:text>
                <xsl:for-each select="fhir:code/fhir:code/fhir:coding">
                    <xsl:value-of select="fhir:system/@value"/>
                    <xsl:text>|</xsl:text>
                    <xsl:value-of select="fhir:code/@value"/>
                </xsl:for-each>
            </xsl:attribute>
            <xsl:attribute name="title">
                <xsl:for-each select="fhir:code/fhir:code/fhir:coding">
                    <xsl:value-of select="fhir:system/@value"/>
                    <xsl:text>|</xsl:text>
                    <xsl:value-of select="fhir:code/@value"/>
                </xsl:for-each>
            </xsl:attribute>
            <xsl:value-of select="fhir:name/fhir:name/@value"/>
        </span>
    </xsl:template>



    <!-- Section 4.1: Add indications from ClinicalUseDefinitions -->

    <xsl:template match="fhir:section[fhir:code/fhir:coding[fhir:system/@value = $emaQrdSystem and fhir:code/@value = '200000029799']]/fhir:text/html:div">
        <xsl:variable name="mpdRef" select="../../../../../fhir:subject/fhir:reference/@value"/>
        <xsl:variable name="cudIndication" select="/fhir:Bundle/fhir:entry/fhir:resource/fhir:ClinicalUseDefinition[fhir:type/@value = 'indication' and fhir:subject/fhir:reference/@value = $mpdRef]" as="node()*"/>
        <xsl:copy>
            <xsl:apply-templates/>
            <div xmlns="http://www.w3.org/1999/xhtml">
                <xsl:apply-templates select="$cudIndication" mode="section41"/>
            </div>
        </xsl:copy>
    </xsl:template>

    <xsl:template match="fhir:ClinicalUseDefinition" mode="section41">
        <p xmlns="http://www.w3.org/1999/xhtml">
            <xsl:attribute name="class">
                <xsl:text>coded-indication </xsl:text>
                <xsl:for-each select="fhir:indication/fhir:diseaseSymptomProcedure/fhir:concept/fhir:coding">
                    <xsl:value-of select="fhir:system/@value"/>
                    <xsl:text>|</xsl:text>
                    <xsl:value-of select="fhir:code/@value"/>
                </xsl:for-each>
            </xsl:attribute>
            <xsl:attribute name="title">
                <xsl:for-each select="fhir:indication/fhir:diseaseSymptomProcedure/fhir:concept/fhir:coding">
                    <xsl:value-of select="fhir:system/@value"/>
                    <xsl:text>|</xsl:text>
                    <xsl:value-of select="fhir:code/@value"/>
                </xsl:for-each>
            </xsl:attribute>
            <xsl:apply-templates select="fhir:text/html:div" mode="#unnamed"/>
        </p>
    </xsl:template>



    <!-- Default processing: recursive copy -->

    <xsl:template match="@* | node()">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>

</xsl:stylesheet>
