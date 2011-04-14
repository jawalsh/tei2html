<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" 
    xmlns:eg="http://www.tei-c.org/ns/Examples"
    xmlns:xdoc="http://www.pnp-software.com/XSLTdoc" exclude-result-prefixes="#all"
    xmlns:fn="http://www.w3.org/2005/xpath-functions"
    xmlns="http://www.w3.org/1999/xhtml">

    <xsl:template name="thematicKeywords">
        <xsl:apply-templates
            select="/TEI/teiHeader/encodingDesc/classDecl/taxonomy[@xml:id='thematic_keywords']"/>
    </xsl:template>

    <xsl:template match="taxonomy[@xml:id='thematic_keywords']">
        <div id="keyword-analysis">
            <div id="keyword-analysis-head">Thematic Categories</div>
            <div id="keyword-analysis-content">
                <xsl:apply-templates/>
            </div>
        </div>
    </xsl:template>


    <!-- supressed elements -->
    <xsl:template match="taxonomy[@xml:id='thematic_keywords']/bibl"/>

    <!--
    <xsl:template match="div[@type='keyword-analysis']/list">
        <div>
            <xsl:apply-templates/>
        </div>
    </xsl:template>
-->


    <xsl:template match="taxonomy[@xml:id='thematic_keywords']//category">
        <xsl:param name="corresp">
            <xsl:value-of select="concat('#',@xml:id)"/>
        </xsl:param>
        <xsl:if test="/TEI/text//l[descendant::seg[@type = 'keyword'][contains(@corresp,$corresp)]]">
            <div>
                <xsl:apply-templates select="catDesc"/>
                <ul>
                    <!-- "and not(@prev)": don't process lines that are only have latter parts of key phrases from previous lines -->
                    <xsl:apply-templates
                        select="/TEI/text//l[descendant::seg[@type = 'keyword' and not(@prev)][contains(@corresp,$corresp)]]"
                        mode="keyword">
                        <xsl:with-param name="corresp" tunnel="yes">
                            <xsl:value-of select="$corresp"/>
                        </xsl:with-param>
                    </xsl:apply-templates>
                </ul>
            </div>
        </xsl:if>
    </xsl:template>

    <xsl:template match="l" mode="keyword">
        <xsl:param name="corresp" tunnel="yes"/>
        <li>
            <xsl:apply-templates>
                <xsl:with-param name="keyword" tunnel="yes">
                    <xsl:value-of select="true()"/>
                </xsl:with-param>
            </xsl:apply-templates>
        </li>
    </xsl:template>



    <xsl:template match="seg[@type='keyword' and not(@prev)]">
        <xsl:param name="keyword" as="xs:boolean" tunnel="yes">
            <xsl:value-of select="false()"/>
        </xsl:param>
        <xsl:param name="corresp" tunnel="yes"/>
        <span>
        <xsl:choose>
            <xsl:when test="$keyword = true() and contains(@corresp,$corresp)">
                
                    <a>
                        <xsl:attribute name="href">
                            <xsl:value-of select="concat('#',@xml:id)"/>
                        </xsl:attribute>
                        <xsl:apply-templates/>
                        <xsl:if test="@next">
                        <xsl:value-of select="' / '"/>
                        <xsl:call-template name="process-next">
                            <xsl:with-param name="id">
                                <xsl:value-of select="substring-after(@next,'#')"/>
                            </xsl:with-param>
                        </xsl:call-template>
                        </xsl:if>
                    </a>
            </xsl:when>
            <xsl:otherwise>
                <xsl:if test="$highlight-keywords = true()">
                    <!-- used for encoding checks -->
                    <xsl:attribute name="style">
                        <xsl:value-of select="'font-style:italic;'"/>
                    </xsl:attribute>
                    <xsl:call-template name="rendition">
                        <xsl:with-param name="defaultRend">
                            <xsl:value-of select="substring-after(@corresp,'#')"/>
                       </xsl:with-param>
                    </xsl:call-template>
                </xsl:if>
                    <xsl:call-template name="atts"/>
                    <xsl:apply-templates/>
                    <xsl:if test="@next and $keyword = true()">
                    <xsl:call-template name="process-next">
                        <xsl:with-param name="id">
                            <xsl:value-of select="substring-after(@next,'#')"/>
                        </xsl:with-param>
                    </xsl:call-template>
                    </xsl:if>
            </xsl:otherwise>
        </xsl:choose>
        </span>
    </xsl:template>

    <xsl:template name="process-next">
        <xsl:param name="id"/>
        <xsl:value-of select="' '"/>
        <xsl:apply-templates select="id($id)"/>
    </xsl:template>



</xsl:stylesheet>
