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



    <!-- jawalsh: added tbody and @name=tableHead and @mode=tableHead template for xhtml -->
    <xsl:template match="table">
        <xsl:if test="$numberTables=true">
            <div class="head">
                <xsl:value-of select="$tableLabel"/>
                <xsl:text> </xsl:text>
                <xsl:number level="any"/>
                <xsl:text>.</xsl:text>
            </div>
        </xsl:if>

        <table>
            <xsl:call-template name="rendition"/>
            <xsl:call-template name="id"/>
            <xsl:if test="head">
                <xsl:text> </xsl:text>
                <xsl:call-template name="tableHead"/>
            </xsl:if>
            <tbody>
                <xsl:apply-templates/>
            </tbody>
        </table>
    </xsl:template>

    <xsl:template name="tableHead">
        <thead>
            <tr>
                
                    <xsl:apply-templates select="./head" mode="tableHead"/>
               
            </tr>
        </thead>
    </xsl:template>

    <xsl:template match="table/head" mode="tableHead">
        <th colspan="0">
            <xsl:call-template name="atts"/>
        <xsl:apply-templates/>
        </th>
    </xsl:template>

    <xsl:template match="table/head"/>

    <xsl:template match="table[@n='toc']/row[not(@role)]">
        <tr>
            <xsl:call-template name="rendition">
                <xsl:with-param name="defaultRend">
                    <xsl:value-of select="'toc'"/>
                </xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="rend"/>
            <xsl:call-template name="id"/>
            <xsl:apply-templates/>
        </tr>
    </xsl:template>
    
    <!-- For Items in Tables of Contents that don't have a page number, such as a section title for a group of sonnets, e.g, Dirae. -->
    <xsl:template match="table[@n='toc']/row[not(@role) and not(cell[@role = 'tocNumber'])]">
        <tr>
            <xsl:call-template name="atts"/>
            <xsl:apply-templates/>
        </tr>
    </xsl:template>
    

  
    
    <xsl:template match="table[@n='toc']/row/cell[role='tocItem']">
        <td>
            <xsl:call-template name="rendition">
                <xsl:with-param name="defaultRend">
                    <xsl:value-of select="'tocItem'"/>
                </xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="rend"/>
            <xsl:call-template name="id"/>
            <xsl:apply-templates/>
        </td>
    </xsl:template>
    
    <xsl:template match="row[@role='tocPageHead']">
        <tr>
            <xsl:call-template name="rendition">
                <xsl:with-param name="defaultRend">
                    <xsl:value-of select="'tocPageHead'"/>
                </xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="rend"/>
            <xsl:call-template name="id"/>
            <xsl:apply-templates/>
        </tr>
    </xsl:template>
    
    <xsl:template match="cell[@role='tocNumber']">
        <td>
            <xsl:call-template name="rendition">
                <xsl:with-param name="defaultRend">
                    <xsl:value-of select="'tocNumber'"/>
                </xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="id"/>
            <xsl:call-template name="rend"/>
            <xsl:apply-templates/>
        </td>
    </xsl:template>
    
    <xsl:template match="cell[@role='tocPageHead']">
        <td>
            <xsl:call-template name="rendition">
                <xsl:with-param name="defaultRend">
                    <xsl:value-of select="'tocPageHead'"/>
                </xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="id"/>
            <xsl:call-template name="rend"/>
            <xsl:apply-templates/>
        </td>
    </xsl:template>
    
    
    


    <xsl:template match="row">
        <tr>
            <xsl:choose>
                <xsl:when test="not(@role = 'data') and not(@role='')">
                    <xsl:call-template name="rendition">
                        <xsl:with-param name="defaultRend">
                            <xsl:value-of select="@role"/>
                        </xsl:with-param>
                    </xsl:call-template>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:call-template name="rendition"/>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:call-template name="id"/>
            <xsl:apply-templates/>
        </tr>
    </xsl:template>

    <xsl:template match="cell">
        <td valign="top">
            <xsl:call-template name="id"/>
            <xsl:choose>
                <xsl:when test="not(@role = 'data') and not(@role='') and not(@rend)">
                    <xsl:call-template name="rendition">
                        <xsl:with-param name="defaultRend">
                            <xsl:value-of select="@role"/>
                        </xsl:with-param>
                    </xsl:call-template>
                    <xsl:call-template name="rend"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:call-template name="rendition"/>
                    <xsl:call-template name="rend"/>
                </xsl:otherwise>
            </xsl:choose>


            <xsl:if test="@cols">
                <xsl:attribute name="colspan">
                    <xsl:value-of select="@cols"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:if test="@rows">
                <xsl:attribute name="rowspan">
                    <xsl:value-of select="@rows"/>
                </xsl:attribute>
            </xsl:if>

            <xsl:if test="@align">
                <xsl:attribute name="align">
                    <xsl:value-of select="@align"/>
                </xsl:attribute>
            </xsl:if>

            <xsl:apply-templates/>
        </td>
    </xsl:template>

</xsl:stylesheet>
