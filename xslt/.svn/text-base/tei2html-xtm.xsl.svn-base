<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" 
    xmlns:eg="http://www.tei-c.org/ns/Examples"
    xmlns:xtm="http://www.topicmaps.org/xtm/" 
    xmlns:xdoc="http://www.pnp-software.com/XSLTdoc" exclude-result-prefixes="#all"
    xmlns:fn="http://www.w3.org/2005/xpath-functions"
    xmlns:tei="http://www.tei-c.org/ns/1.0">
    <xdoc:doc type="stylesheet">
        <xdoc:author>John A. Walsh</xdoc:author>
        <xdoc:copyright>Copyright 2006 John A. Walsh</xdoc:copyright>
        <xdoc:short>XSLT stylesheet to transform TEI P5 documents to XHTML.</xdoc:short>
    </xdoc:doc>

    <xsl:template name="nameGloss">
        <xsl:param name="target"/>
        <span>
            <xsl:attribute name="class" select="concat('showTip ',$target)"/>
            <span>
                <xsl:call-template name="id"/>
                <xsl:call-template name="rend"/>
                <xsl:call-template name="rendition">
                    <xsl:with-param name="defaultRend" select="'ref'"/>
                </xsl:call-template>
                <xsl:value-of select="$refSymbol"/>
                <xsl:apply-templates select="$xtm//xtm:topic[@id = $target]"/>
            </span>
        </span>
    </xsl:template>
    
    <xsl:template match="xtm:topic">
<!--    <xsl:template match="xtm:topic[xtm:instanceOf/xtm:topicRef/@href='#person']"> -->
        <span class="tipContent">
            <xsl:attribute name="id">
                <xsl:value-of select="@id"/>
            </xsl:attribute>
            <span class="glossTerm">
                <xsl:value-of select="normalize-space(xtm:name/xtm:value)"/>
                <xsl:choose>
                <xsl:when test="xtm:occurrence/xtm:type/xtm:topicRef/@href = '#date-of-birth'">
                    <xsl:text> (</xsl:text>
                    <xsl:value-of
                        select="normalize-space(xtm:occurrence[xtm:type/xtm:topicRef/@href='#date-of-birth']/xtm:resourceData//tei:date/@when)"/>
                    <xsl:text>-</xsl:text>
                    <xsl:value-of
                        select="normalize-space(xtm:occurrence[xtm:type/xtm:topicRef/@href='#date-of-death']/xtm:resourceData//tei:date/@when)"/>
                    <xsl:text>)</xsl:text>
                </xsl:when>
                <xsl:when test="xtm:occurrence/xtm:type/xtm:topicRef/@href = '#date'">
                    <xsl:value-of
                        select="concat(' (',normalize-space(xtm:occurrence[xtm:type/xtm:topicRef/@href='#date']/xtm:resourceData//tei:date),')')"/>
                </xsl:when>
                </xsl:choose>
            </span>
            <span class="gloss">
                <xsl:apply-templates select="xtm:occurrence[xtm:type/xtm:topicRef/@href = '#description']/xtm:resourceData"/>
                <xsl:if test="xtm:occurrence[xtm:type/xtm:topicRef/@href = '#article'] or xtm:occurrence[xtm:type/xtm:topicRef/@href = '#collection']">
                    <div>
                        <span style="display:block; font-weight:bold;">Resources:</span>
                        <ul style="margin-left:2em;">
                            <xsl:apply-templates select="xtm:occurrence[xtm:type/xtm:topicRef/@href = '#article'] | xtm:occurrence[xtm:type/xtm:topicRef/@href = '#collection']"/>
                        </ul>
                    </div>
                </xsl:if>
            </span>
        </span>
    </xsl:template>
    
    <xsl:template match="xtm:resourceData/tei:div">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="xtm:occurrence[xtm:type/xtm:topicRef/@href = '#article'] | xtm:occurrence[xtm:type/xtm:topicRef/@href = '#collection']">
        <li>
            <a><xsl:attribute name="href" select="xtm:resourceRef/@href"/><xsl:value-of select="xtm:resourceRef/@href"/></a>
        </li>
    </xsl:template>
    
    
    
    <xsl:template name="getXtmName">
        <xsl:param name="target"/>
        <xsl:param name="scope"/>
        <xsl:choose>
            <xsl:when test="$scope = ''">
                <xsl:value-of select="$xtm//xtm:topic[@id = $target]/xtm:name/xtm:value"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$xtm//xtm:topic[@id = $target]/xtm:name/xtm:variant[xtm:scope/xtm:topicRef/@href = concat('#',$scope)]/xtm:resourceData"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
</xsl:stylesheet>
