<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0">
    <xsl:output method="text"/>
    <xsl:template match="/">
        <xsl:apply-templates select="//tagsDecl"/>
    </xsl:template>
    <xsl:template match="//tagsDecl">
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="rendition[@scheme='css']">
        <xsl:value-of select="concat('.',@xml:id,' {')"/>
        <xsl:value-of select="concat(.,'}')"/>
    </xsl:template>
    <xsl:template match="rendition[not(@scheme='css')]"/>
</xsl:stylesheet>
