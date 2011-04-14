<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" 
    xmlns:eg="http://www.tei-c.org/ns/Examples"
    xmlns:xdoc="http://www.pnp-software.com/XSLTdoc" exclude-result-prefixes="#all"
    xmlns:fn="http://www.w3.org/2005/xpath-functions">
    <xdoc:doc type="stylesheet">
        <xdoc:author>John A. Walsh</xdoc:author>
        <xdoc:copyright>Copyright 2006 John A. Walsh</xdoc:copyright>
        <xdoc:short>XSLT stylesheet to transform TEI P5 documents to XHTML.</xdoc:short>
    </xdoc:doc>


    
    <xsl:template match="entry">
        <span class="tipContent">
            <xsl:attribute name="id">
                <xsl:value-of select="@xml:id"/>
            </xsl:attribute>
            <span class="glossTerm">
                <xsl:value-of select="normalize-space(form/orth)"/>
            </span>
            <span class="gloss">
                <xsl:apply-templates select=".//def"/>
            </span>
        </span>
    </xsl:template>
    
    <xsl:template match="def">
        <xsl:param as="xs:integer" name="defNum">
            <xsl:value-of select="count(ancestor::hom/sense)"/>
        </xsl:param>
        <xsl:message>
            <xsl:text>tei2html: </xsl:text> <xsl:value-of select="ancestor::entry/@xml:id"/>: <xsl:value-of select="$defNum"/>
        </xsl:message>
        <xsl:choose>
            <xsl:when test="$defNum > 1">
            <span class="sense">
                <xsl:number count="def" from="hom" level="any"/>
                <xsl:text>. </xsl:text>
                <xsl:apply-templates/>
            </span>
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    

    <xsl:template match="def/bibl"/>
</xsl:stylesheet>
