<?xml version="1.0" encoding="UTF-8"?>
<!-- checked. jawalsh. $Id$ -->
<xsl:stylesheet xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" 
    xmlns:eg="http://www.tei-c.org/ns/Examples"
    xmlns:xdoc="http://www.pnp-software.com/XSLTdoc" exclude-result-prefixes="#all"
    xmlns:fn="http://www.w3.org/2005/xpath-functions"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns="http://www.w3.org/1999/xhtml">
    

    


    
        <xdoc:author>John A. Walsh</xdoc:author>
        <xdoc:copyright>Copyright 2006 John A. Walsh</xdoc:copyright>
        <xdoc:short>XSLT stylesheet to transform TEI P5 documents to XHTML.</xdoc:short>

    <!-- naming conventions:
        
         named templates:
         parameters that indicate option material in output use "include...", e.g., "includeDocumentInformation"
        
    -->
    <xsl:variable name="all-endnotes" select="//note[@place = 'end']"/>
    
    <xsl:template name="endnotes">
            <xsl:if test="$all-endnotes">
                <div id="endnotes">
                    <xsl:if test="supplyEndnotesHead = true()">
                    <h1>Notes</h1>
                    </xsl:if>
                    <xsl:apply-templates select="//note[@place = 'end']" mode="notes"/>
                </div>
            </xsl:if>
    </xsl:template>

    <xsl:template match="note[not(@type = 'chronoLetter') and not(@type = 'caption') and @place]" priority="1">
        <xsl:apply-templates select="." mode="generated-reference"/>
    </xsl:template>
    
    <!-- For Swinburne component/combo files to include note that don't appear in the component <text> -->
    <xsl:template match="note[@type = 'external']" priority="99">
        <span>
            <xsl:call-template name="atts"/>
            <xsl:apply-templates/>
        </span>
    </xsl:template>    
    
    
    <xsl:template match="note[@place = 'end']" mode="generated-reference">
        <a class="noteRef">
            <xsl:attribute name="href">
                <xsl:choose>
                    <xsl:when test="@xml:id">
                        <xsl:value-of select="concat('#',@xml:id)"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="concat('#',generate-id())"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:attribute>
            <xsl:text>[</xsl:text>
            <xsl:number count="//note[@place = 'end']" level="any"/>
            <xsl:text>]</xsl:text>
        </a>
    </xsl:template>
    
    <xsl:template match="note">
        <span>
            <xsl:call-template name="atts"/>
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
        
        
    
  
    
    <xsl:template match="note[@place = 'end' or @place = 'foot']" mode="notes">
        <div class="endnote">
            <xsl:attribute name="id">
                <xsl:choose>
                    <xsl:when test="@xml:id">
                        <xsl:value-of select="@xml:id"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="generate-id()"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:attribute>
            <span class="noteRef">
                <xsl:text>[</xsl:text>
                <xsl:number count="//note[@place = 'end']" level="any" from="/"/>
                <xsl:text>]</xsl:text>
            </span>
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <xsl:template match="ptr[@type = 'biblref']" priority="10">
        <xsl:variable name="bibl" select="id(substring-after(@target,'#'))"/>
        <span>
            <xsl:call-template name="id"/>
            <xsl:call-template name="rendition">
                <xsl:with-param name="defaultRend" select="'biblref'"/>
            </xsl:call-template>
            <xsl:call-template name="rend"/>
            <xsl:value-of select="'['"/>
            <a href="{@target}">
                <xsl:choose>
                    <xsl:when test="$bibl/author">
                        <xsl:choose>
                            <xsl:when test="$bibl/author/persName/surname">
                                <xsl:value-of select="concat(normalize-space($bibl/author[1]/persName/surname),'. ')"/>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:value-of select="concat(normalize-space($bibl/author[1]),'. ')"/>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:when>
                    <xsl:when test="$bibl/editor">
                        <xsl:choose>
                            <xsl:when test="$bibl/editor/persName/surname">
                                <xsl:value-of select="concat(normalize-space($bibl/editor[1]/persName/surname),'. ')"/>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:value-of select="concat(normalize-space($bibl/editor[1]),'. ')"/>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:when>
                    <xsl:when test="$bibl/name[@type = 'product']">
                        <xsl:variable name="product">
                            <xsl:apply-templates select="$bibl/name[@type = 'product']"/>
                        </xsl:variable>
                        <xsl:choose>
                            <xsl:when test="ends-with(normalize-space($product), '.') or 
                                ends-with(normalize-space($product), '.’') or
                                ends-with(normalize-space($product), '.”')">
                                <xsl:value-of select="concat(normalize-space($product), ' ')"/>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:value-of select="concat(normalize-space($product), '. ')"/>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:when>
                    <xsl:when test="$bibl/title[@level = 'a']">
                        <xsl:variable name="title">
                            <xsl:apply-templates select="$bibl/title[@level = 'a'][1]"/>
                        </xsl:variable>
                        <!-- check whether or not to add period. -->
                        <xsl:choose>
                            <xsl:when test="ends-with(normalize-space($title), '.') or 
                                ends-with(normalize-space($title), '.’') or
                                ends-with(normalize-space($title), '.”')">
                                <xsl:value-of select="concat(normalize-space($title), ' ')"/>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:value-of select="concat(normalize-space($title), '. ')"/>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:when>
                    <xsl:when test="$bibl/title">
                        <xsl:variable name="title">
                            <xsl:apply-templates select="$bibl/title[1]"/>
                        </xsl:variable>
                        <!-- check whether or not to add period. -->
                        <xsl:choose>
                            <xsl:when test="ends-with(normalize-space($title), '.') or 
                                ends-with(normalize-space($title), '.’') or
                                ends-with(normalize-space($title), '.”')">
                                <xsl:copy-of select="$title" />
                                <xsl:value-of select="' '"/>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:copy-of select="$title" />
                                <xsl:value-of select="'. '"/>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:message>WARNING: No author/editor in bibl</xsl:message>
                    </xsl:otherwise>
                </xsl:choose>
                <xsl:choose>
                    <xsl:when test="$bibl/note[@type = 'ms'] and $bibl/date[@type = 'creation']">
                        <xsl:value-of select="$bibl/date[@type = 'creation']"/>
                    </xsl:when>
                    <xsl:when test="$bibl/date[@type = 'publication']">
                        <xsl:value-of select="$bibl/date[@type = 'publication']"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="$bibl/date"/>
                    </xsl:otherwise>
                </xsl:choose>
            </a>
            <xsl:value-of select="']'"/>
        </span>
    </xsl:template>
    
    <xsl:template match="note[@type = 'annotation']">
            <span class="tipContent">
                <xsl:call-template name="id"/>
                <xsl:apply-templates/>
            </span>
    </xsl:template>
    
    <xsl:template match="bibl/note[@type = 'annotation']">
        <div>
            <xsl:call-template name="atts"/>
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    
    
    <xsl:template match="note[@place = 'inline']" priority="10">
        <span>
            <xsl:call-template name="id"/>
            <xsl:call-template name="rendition">
                <xsl:with-param name="defaultRend" select="'note-inline'"/>
            </xsl:call-template>
            <xsl:call-template name="rend"/>
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <xsl:template match="note[@type = 'comment']" priority="10">
        <span class="comment">
        <xsl:value-of select="'&lt;!-- '"/>
        <xsl:apply-templates/>
        <xsl:value-of select="' -->'"/>
        </span>
    </xsl:template>
    
    <xsl:template match="note[@type = 'dev']" priority="99"/>
    
</xsl:stylesheet>
