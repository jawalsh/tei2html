<?xml version="1.0" encoding="UTF-8"?>
<!-- checked. jawalsh. $Id$ -->
<xsl:stylesheet xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:eg="http://www.tei-c.org/ns/Examples"
    xmlns:xdoc="http://www.pnp-software.com/XSLTdoc" exclude-result-prefixes="#all"
    xmlns:fn="http://www.w3.org/2005/xpath-functions" xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:xtf="http://cdlib.org/xtf" xmlns="http://www.w3.org/1999/xhtml">
    <!-- naming conventions:
        
        named templates:
        parameters that indicate option material in output use "include...", e.g., "includeDocumentInformation"
        
    -->
    <xsl:import href="tei2html-conf.xsl"/>
    <xsl:import href="tei2html-main.xsl"/>
    <xsl:import href="tei2html-tables.xsl"/>
    <xsl:import href="tei2html-linking.xsl"/>
    <xsl:import href="tei2html-docinfo.xsl"/>
    <xsl:import href="tei2html-notes.xsl"/>
    <!--
        <xsl:import href="tei2html-tagdoc.xsl"/>
    -->
    <xsl:import href="tei2html-lists.xsl"/>
    <xsl:import href="tei2html-xtm.xsl"/>
    <xsl:import href="tei2html-dict.xsl"/>
    <xsl:import href="tei2html-keywords.xsl"/>
    <!--
        <xsl:import href="xml-to-string.xsl"/>
        <xsl:import href="cbml.xsl"/>
    -->
    <xsl:import href="tei2html-xtf.xsl"/>
    <xsl:import href="../../../../swinburneCommon/swinburneCommon.xsl"/>
    
    <xsl:param name="displayPageImageLinks" as="xs:boolean" select="true()"/>
    <xsl:param name="xtf" as="xs:boolean" select="true()"/>
    <xsl:param name="supplyEndnoteHead" as="xs:boolean" select="false()"/>
    <xsl:param name="acsSymbol" select="'†'"/>
    
    <!-- moved to swinburneCommon.xsl
    <xsl:param name="imagePath" as="xs:string" select="concat($xtfURL, 'images/swinburne/')"/>
    -->
    


    <xdoc:author>John A. Walsh</xdoc:author>
    <xdoc:copyright>Copyright 2006 John A. Walsh</xdoc:copyright>
    <xdoc:short>XSLT stylesheet to transform TEI P5 documents to XHTML.</xdoc:short>


    <xsl:output method="xhtml" media-type="text/html"
        doctype-public="-//W3C//DTD XHTML 1.1//EN" doctype-system="http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd"
        cdata-section-elements="xsl:comment eg:egXML" indent="no" encoding="utf-8"
        exclude-result-prefixes="#all" omit-xml-declaration="no"/>

    <!-- overridden methods -->
    <!-- from tei2html-main.xsl -->
    <xsl:template match="TEI|teiCorpus">
        <xsl:choose>
            <!-- reloaded URLs can have *both* $outputAsDiv=true *and* xtfBar=true, so need to test for xtfBar first-->
            <xsl:when test="$xtfBar = true()">
                <xsl:call-template name="xtfBar"/>
            </xsl:when>
            <xsl:when test="$outputAsDiv = true()">
                <div id="output-content">
                    <xsl:if test="contains(/TEI/text/body/@rendition,'#wide')">
                        <xsl:attribute name="style" select="'width:100%;'"/>
                    </xsl:if>
                    <xsl:if test="$includeDocumentInformation = true()">
                        <xsl:call-template name="docinfo"/>
                    </xsl:if>
                    <xsl:if test="$includeDocHeader = true()">
                        <xsl:call-template name="docHeader"/>
                    </xsl:if>
                    <xsl:apply-templates/>
                    <xsl:call-template name="endnotes"/>
                </div>
            </xsl:when>
            <xsl:otherwise>
                <html xmlns="http://www.w3.org/1999/xhtml">
                    <!-- no id attribute on <html>.  Need to stick id in a <meta> tag somewhere -->
                    <xsl:call-template name="htmlHead">
                        <xsl:with-param name="headTitle">
                            <xsl:call-template name="generateTitle"/>
                        </xsl:with-param>
                    </xsl:call-template>
                    <body>
                        <xsl:attribute name="onload">
                            <xsl:value-of select="'init();'"/>
                            <xsl:if test="$smode = 'within' and number(/*/@xtf:hitCount) != 0">
                                <xsl:value-of
                                    select="'javascript:window.location.hash=&quot;hitNum_1&quot;;'"
                                />
                            </xsl:if>
                        </xsl:attribute>
                        <div id="main">
                            <xsl:call-template name="banner"/>
                            <div id="content">
                                <div id="discovery">
                                    <div id="ext-panel-xtfBar"/>
<!--                                    <xsl:call-template name="xtfBar"/> -->
                                    <xsl:call-template name="toc"/>
                                </div>
                                <div id="ext-panel"/>
                                <!--
                                <div id="output-content">
                                    <xsl:if test="$includeDocumentInformation = true()">
                                        <xsl:call-template name="docinfo"/>
                                    </xsl:if>
                                    <xsl:if test="$includeDocHeader = true()">
                                        <xsl:call-template name="docHeader"/>
                                    </xsl:if>
                                    <xsl:apply-templates/>
                                </div>
                                -->
                                <div class="top"><span class="jslink" onclick="jumpToAnchor('main')">top</span></div>
                                    
                            </div>
                            <xsl:call-template name="footer"/>
                        </div>
                    </body>
                </html>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <!-- pb -->
    
    <xsl:template name="pb-handler">
        <xsl:param name="pn"/>
        <xsl:param name="page-id"/>
        
        <span class="page-num">
            <xsl:call-template name="atts"/>
            <span class="pbNote">page: </span>
            <xsl:value-of select="@n"/>
            <xsl:text> </xsl:text>
        </span>
        
        <xsl:if test="$displayPageImageLinks = true()">
            <xsl:call-template name="fax-thumbnail-link">
                <xsl:with-param name="page-id" select="$page-id"/>
            </xsl:call-template>
        </xsl:if>
    </xsl:template>

    <xdoc:doc>
        <xdoc:short>Outputs XHTML head and child elements.</xdoc:short>
    </xdoc:doc>
    
    <!-- overrides template in tei2html-notes.xsl -->
    <xsl:template match="note" mode="generated-reference">
        <xsl:param name="target">
            <xsl:choose>
                <xsl:when test="@xml:id">
                    <xsl:value-of select="@xml:id"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="generate-id()"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:param>
       <span class="{concat('showTip ', $target)}" style="cursor:pointer">
           <xsl:choose>
               <xsl:when test=".//ref">
                   <xsl:apply-templates select=".//ref[1]"/>
               </xsl:when>
               <xsl:otherwise>
                   <xsl:value-of select="$refSymbol"/>
               </xsl:otherwise>
           </xsl:choose>
       </span>
        <!--
        <span class="tooltipData" id="{$target}">
            <xsl:apply-templates/>
        </span>
        -->
    </xsl:template>
    <!-- overrides from tei2html-notes.xsl -->
    <xsl:template match="note[@place = 'end' or @place = 'foot']" mode="notes" priority="1">
        <div>
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
            <xsl:call-template name="rendition"/>
            <xsl:call-template name="rend"/>
            <xsl:apply-templates/>
            <!--
            <span class="noteRef">
                <xsl:choose>
                    <xsl:when test=".//ref">
                        <xsl:apply-templates/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="$refSymbol"/>
                        <xsl:apply-templates/>
                    </xsl:otherwise>
                </xsl:choose>
            </span>
            -->
        </div>
    </xsl:template>
    
    <xsl:template match="ptr[@type = 'note']">
        <xsl:param select="substring-after(@target,'#')" name="id"/>
        <xsl:apply-templates select="//*[@xml:id = $id]" mode="tooltip"/>
    </xsl:template>
    
    <xsl:template match="note" mode="tooltip">
        <xsl:param name="target">
            <xsl:choose>
                <xsl:when test="@xml:id">
                    <xsl:value-of select="@xml:id"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="generate-id()"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:param>
        <span class="{concat('showTip ', $target)}" style="cursor:pointer">
            <span class="ref">
            <xsl:choose>
                <xsl:when test=".//ref">
                    <xsl:apply-templates select=".//ref[1]"/>
                </xsl:when>
                <xsl:when test="@resp = '#acs'">
                    <xsl:value-of select="$acsSymbol"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="$refSymbol"/>
                </xsl:otherwise>
            </xsl:choose>
            </span>
        </span>
        <!--
            <span class="tooltipData" id="{$target}">
            <xsl:apply-templates/>
            </span>
        -->
    </xsl:template>
    
    
    
    
    

    <!-- parameterize URLs below-->
    



</xsl:stylesheet>
