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
    
    <xdoc:doc>Generates a table with tag documentation for an individual element.</xdoc:doc>
    <xsl:template match="tagDoc">
        <div>
            <h1><xsl:apply-templates select="./gi" mode="head"/></h1>
            <table class='graphic'>
                <xsl:apply-templates/>
            </table>
        </div>
    </xsl:template>
    
    <xsl:template match="elementSpec">
        <xsl:param name="element">
            <xsl:choose>
                <xsl:when test="altIdent">
                    <xsl:value-of select="concat('&lt;',normalize-space(altIdent),'&gt;')"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="concat('&lt;',normalize-space(@ident),'&gt;')"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:param>
        <div class="elementSpec">
            <h1><xsl:value-of select="$element"/></h1>
            <table class="tagdoc">
                <tbody>
                    <tr><td colspan="2"><span class="label"><xsl:value-of select="$element"/></span> <xsl:apply-templates select="desc"/></td></tr>
                    <xsl:if test="@ns">
                        <tr><td class="label">Namespace</td><td><xsl:value-of select="@ns"/></td></tr>
                    </xsl:if>
                    <xsl:if test="exemplum">
                        <xsl:apply-templates select=".//exemplum"/>
                    </xsl:if>
                </tbody>
            </table>
        </div>
    </xsl:template>
    
        
                        
                        

    

    <xsl:template match="gi|tag"> 
        <span>
            <xsl:call-template name="rendition">
                <xsl:with-param name="defaultRend"><xsl:value-of select="'code'"/></xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="id"/>
            <xsl:text>&lt;</xsl:text>
            <xsl:apply-templates />
            <xsl:text>&gt;</xsl:text>
        </span>
    </xsl:template>
    
    <xsl:template match="att">
        <span>
            <xsl:call-template name="rendition">
                <xsl:with-param name="defaultRend"><xsl:value-of select="'code'"/></xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="id"/>
            <xsl:value-of select="concat('@',normalize-space(.))"/>
        </span>
    </xsl:template>
    
    
    <xdoc:doc>Special template for gi as child of tagDoc, which is a row in the table for tagDoc documentation</xdoc:doc>
    <xsl:template match="tagDoc/gi">
        <tr><td class="label"><tt>&lt;<xsl:value-of select="."/>&gt;</tt></td><td class="gi"><xsl:apply-templates select="../desc" mode="table"/></td></tr>
    </xsl:template>
    <xsl:template match="tagDoc/gi" mode="head">
        <xsl:text>&lt;</xsl:text><xsl:value-of select="."/><xsl:text>&gt;</xsl:text>
    </xsl:template>
    
    <!-- 
    <xsl:template match="desc" mode="table">
        <xsl:apply-templates/>
    </xsl:template>
    -->
    
    <xsl:template match="attList">
        <tr>
            <td class="label">Attributes</td>
            <xsl:choose>
                <xsl:when test="not(./child::*) and not(../classes)">
                    <td>Global attributes only.</td>
                </xsl:when>
                <xsl:when test="not(./child::*) and (../classes)">
                    <td>Global attributes and those inherited from <xsl:value-of select="../classes"/>.</td>
                    <!--
                        <xsl:for-each select="id(../classes/@names)">
                        <xsl:value-of 
                        </xsl:for-each>
                    -->
                </xsl:when>
                <xsl:when test="(./child::*) and not(../classes)">
                    <td>(In addition to Global attributes.)<br/><xsl:apply-templates/></td>
                </xsl:when>
                <xsl:otherwise>
                    <td>(In addition to Global attributes and those inherited from <xsl:value-of select="../classes"/>.)<br/><xsl:apply-templates/></td>
                </xsl:otherwise>
            </xsl:choose>
        </tr>
    </xsl:template>
    
    <xsl:template match="attDef">
        <table><tr><td><tt><xsl:value-of select="./attName"/></tt></td><td><xsl:apply-templates select="desc" mode="table"/><xsl:apply-templates/></td></tr></table>
    </xsl:template>
    
    <xsl:template match="attName"/>
    
    <xsl:template match="datatype"><p><i>Datatype: </i><xsl:apply-templates/></p></xsl:template>
    
    <xsl:template match="valDesc"><p><xsl:apply-templates/></p></xsl:template>
    
    <xsl:template match="valList">
        <xsl:if test="@type='open'"><p>Suggested values include:</p></xsl:if>
        <xsl:if test="@type='closed'"><p>Legal values are:</p></xsl:if>
        <dl>
            <xsl:apply-templates/>
        </dl>
    </xsl:template>
    
    <xsl:template match="valList/val">
        <dt><xsl:apply-templates/></dt>
    </xsl:template>
    
    <xsl:template match="valList/desc">
        <dd><xsl:apply-templates/></dd>
    </xsl:template>
    
    <xsl:template match="default"><p><i>Default: </i><xsl:apply-templates/></p></xsl:template>
    
    <xsl:template match="remarks"><tr><td class='label'>Notes</td><td><xsl:apply-templates/></td></tr></xsl:template>
    
    <xsl:template match="exemplum">
        <tr><td class='label'>Example</td><td class="wrap"><xsl:apply-templates/></td></tr>
    </xsl:template>
    
    <xsl:template match="eg">
        <div>
            <xsl:call-template name="rendition">
                <xsl:with-param name="defaultRend">
                    <xsl:value-of select="'eg'"/>
                </xsl:with-param>
            </xsl:call-template>
        <pre><xsl:apply-templates/></pre>
            <xsl:call-template name="makeEgCaption"/>
        </div>
    </xsl:template>
    
    <xsl:template match="classes">
        <tr><td class="label">Class(es)</td><td><xsl:value-of select="."/></td></tr>
    </xsl:template>
    
    <xsl:template match="elemDecl">
        <tr><td class="label">Declaration</td><td><pre><xsl:value-of select="."/><xsl:value-of select="../attlDecl"/></pre></td></tr>
    </xsl:template>
    
    <xsl:template match="attlDecl"/>
    
    <xsl:template match="code">
        <span>
            <xsl:call-template name="id"/>
            <xsl:call-template name="rendition">
                <xsl:with-param name="defaultRend">
                    <xsl:value-of select="'code'"/>
                </xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="rend"/>
            <xsl:apply-templates />
        </span>
    </xsl:template>
    
    <xsl:template match="code[contains(@rendition,'#block')]">
        <pre>
            <xsl:call-template name="id"/>
            <xsl:call-template name="rendition">
                <xsl:with-param name="defaultRend">
                    <xsl:value-of select="'code'"/>
                </xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="rend"/>
            <xsl:apply-templates />
        </pre>
    </xsl:template>
    

    <xsl:template match="eg:egXML">
        <div>
            <xsl:call-template name="rendition">
                <xsl:with-param name="defaultRend">
                    <xsl:value-of select="'eg'"/>
                </xsl:with-param>
            </xsl:call-template>
            
        <pre><tt>
            <xsl:call-template name="xml-to-string" exclude-result-prefixes="eg">
                <xsl:with-param name="node-set">
            <xsl:copy-of select="node()|@*"/>
                </xsl:with-param>
            </xsl:call-template>
        </tt></pre>
            <xsl:call-template name="makeEgCaption"/>
        </div>
    </xsl:template>
    
    <xsl:template name="makeEgCaption">
        <xsl:if test="following-sibling::note[@type = 'caption']">
            <div class="caption">
                <b>
                    <xsl:value-of select="'Example '"/>
                    <xsl:number level="any" count="eg[following-sibling::note[@type = 'caption']]|eg:egXML[following-sibling::note[@type = 'caption']]"/>
                    <xsl:value-of select="'. '"/>
                </b>
                <xsl:apply-templates select="following-sibling::note[@type = 'caption'][1]" mode="caption"/>
            </div>
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="note[@type = 'caption']"/>
    <xsl:template match="note[@type = 'caption']" mode='caption'>
        <xsl:apply-templates/>
    </xsl:template>
    
        
    
  
    
</xsl:stylesheet>
