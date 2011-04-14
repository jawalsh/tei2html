<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" 
    xmlns:eg="http://www.tei-c.org/ns/Examples"
    xmlns:cbml="http://www.cbml.org/ns/1.0"
    xmlns:xdoc="http://www.pnp-software.com/XSLTdoc" exclude-result-prefixes="#all"
    xmlns:fn="http://www.w3.org/2005/xpath-functions">
    <!-- cbml block elements -->
   
    <xsl:template match="cbml:advert|cbml:panel|cbml:indicia|caption">
        <div>
            <xsl:call-template name="atts"/>
            <xsl:apply-templates/>
        </div>
    </xsl:template>

    <!-- cbml inline elements -->
    <xsl:template match="cbml:price">
        <span>
            <xsl:call-template name="atts"/>
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <xsl:key name="who" match="person/persName" use="parent::person/@xml:id"/>
    <xsl:template match="cbml:balloon">
        <div>
            <xsl:call-template name="atts"/>
            <div style="font-weight: bold;"><xsl:value-of select="key('who', substring-after(@who,'#'))"/>    </div>
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
        

</xsl:stylesheet>
