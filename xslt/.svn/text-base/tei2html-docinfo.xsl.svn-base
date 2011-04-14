<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" 
    xmlns:eg="http://www.tei-c.org/ns/Examples"
    xmlns:xdoc="http://www.pnp-software.com/XSLTdoc" exclude-result-prefixes="#all"
    xmlns:fn="http://www.w3.org/2005/xpath-functions"
    xmlns="http://www.w3.org/1999/xhtml">
    
    <xdoc:doc type="stylesheet">
        <xdoc:author>John A. Walsh</xdoc:author>
        <xdoc:copyright>Copyright 2006 John A. Walsh</xdoc:copyright>
        <xdoc:short>XSLT stylesheet to transform TEI P5 documents to XHTML.</xdoc:short>
    </xdoc:doc>
    
    <xdoc:doc>Outputs a div containing a variety of document metadata.  This template is a likely candidate for local customization and so lives in a separate tei2html-moduleName.xsl module. Output includes a script element that references a swap.js file used to hid and display the document information. The data for "genre" comes form an extention—a type attribute added to text.</xdoc:doc>
    <xsl:template name="docinfo">
        <xsl:param name="id"><xsl:value-of select="/TEI/@xml:id"/></xsl:param>
        <!--
        <script type="text/javascript" src="js/swap.js"><xsl:comment>No empty script tags</xsl:comment></script>
        -->
        <div id="docInfoLink">[<a href="javascript:showDocInfo()">show document information</a>]</div>
        <div id="show">[<a href="javascript:showDocInfo()">show document information</a>]</div>
        <div id="hide">[<a href="javascript:hideDocInfo()">hide document information</a>]</div>
        <div id="empty"><span><xsl:text> </xsl:text></span></div>
        <div id="docInfoShell"><span><xsl:text> </xsl:text></span></div>
        <div id="docInfoHidden">
            <div id="docInfo">
                <h1>Document Information</h1>
                <ul>
                    <xsl:if test="teiHeader/fileDesc/titleStmt/author">
                    <li>
                        <b>author: </b>
                        <xsl:choose>
                            <xsl:when test="teiHeader/fileDesc/titleStmt/author/persName/@key">
                                <xsl:call-template name="getXtmName">
                                    <xsl:with-param name="target">
                                        <xsl:value-of select="teiHeader/fileDesc/titleStmt/author/persName/@key"/>
                                    </xsl:with-param>
                                </xsl:call-template>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:value-of select="teiHeader/fileDesc/titleStmt/author"/>
                                <!--
                                <xsl:value-of select="teiHeader/fileDesc/titleStmt/author/"/>
                                -->
                            </xsl:otherwise>
                        </xsl:choose>
                    </li>
                    </xsl:if>
                    <li>
                        <b>title: </b>
                        <xsl:value-of select="teiHeader/fileDesc/titleStmt/title"/>
                    </li>
                    <xsl:if test="teiHeader/fileDesc/titleStmt/editor">
                    <li>
                        <b>editor: </b>
                        <xsl:choose>
                            <xsl:when test="teiHeader/fileDesc/titleStmt/editor/persName/@key">
                                <xsl:call-template name="getXtmName">
                                    <xsl:with-param name="target">
                                        <xsl:value-of select="teiHeader/fileDesc/titleStmt/editor/persName/@key"/>
                                    </xsl:with-param>
                                </xsl:call-template>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:value-of select="teiHeader/fileDesc/titleStmt/editor"/>
                                <!--
                                    <xsl:value-of select="teiHeader/fileDesc/titleStmt/author/"/>
                                -->
                            </xsl:otherwise>
                        </xsl:choose>
                    </li>
                    </xsl:if>
                    <li>
                        <b>publisher: </b>
                        <xsl:value-of select="normalize-space(teiHeader/fileDesc/publicationStmt/publisher)"/>
                    </li>
                    <li>
                        <b>rights:</b>
                        <xsl:apply-templates select="teiHeader/fileDesc/publicationStmt/availability"/>
                    </li>
                    <!--
                    <li>
                        <b>genre: </b>
                        <xsl:choose>
                            <xsl:when test="/TEI.2/text/@type = 'poem'">
                                <xsl:text>poetry</xsl:text>
                            </xsl:when>
                            <xsl:when test="/TEI.2/text/@type">
                                <xsl:value-of select="/TEI.2/text/@type"/>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:text>unspecified</xsl:text>
                            </xsl:otherwise>
                        </xsl:choose>
                    </li>
                    -->
                    <li>
                        <b>source document: </b>
                        <br/>
                        <xsl:apply-templates select="/TEI/teiHeader/fileDesc/sourceDesc" mode="docinfo"/>
                    </li>
                    <li>
                        <b>swinburne project id: </b><span id="said"><xsl:value-of select="/TEI/@xml:id"/></span></li>
                    
                    <li>
                        <b>XML source:</b>
                        <br/>
                        <a>
                            <xsl:attribute name="href">
                                <xsl:value-of
                                    select="concat($xmlSourcePath,$id,'/')"
                                />
                            </xsl:attribute>
                            <xsl:value-of
                                select="concat($xmlSourcePath,$id,'/')"
                            />
                        </a>
                    </li>
                </ul>
            </div>
        </div>
    </xsl:template>
    
    <xsl:template match="/TEI/teiHeader/fileDesc/sourceDesc" mode="docinfo">
        <span class="bibl">
            <xsl:call-template name="get-sourceDesc-author"/>
            <xsl:call-template name="get-sourceDesc-editor-analytic"/>
            <xsl:call-template name="get-sourceDesc-title-analytic"/>
            <xsl:call-template name="get-sourceDesc-title-monogr"/>
            <xsl:call-template name="get-sourceDesc-editor-monogr"/>
            <xsl:call-template name="get-sourceDesc-extent"/>
            <xsl:call-template name="get-sourceDesc-pubPlace"/>
            <xsl:call-template name="get-sourceDesc-publisher"/>
            <xsl:call-template name="get-sourceDesc-date"/>
            <xsl:call-template name="get-sourceDesc-biblScope"/>
            <xsl:call-template name="get-sourceDesc-origPubInfo"/>
            
            
        
        </span>
    </xsl:template>
    
    <xsl:template match="p[parent::availability]"><xsl:apply-templates/></xsl:template>
    
    <xsl:template name="get-sourceDesc-author">
        <xsl:param name="author">
        <xsl:choose>
            <xsl:when test="/TEI/teiHeader/fileDesc/sourceDesc/biblStruct/analytic/author/persName/@key">
                    <xsl:call-template name="getXtmName">
                        <xsl:with-param name="target" select="/TEI/teiHeader/fileDesc/sourceDesc/biblStruct/analytic/author/persName/@key"/>
                    </xsl:call-template>
            </xsl:when>
            <xsl:when test="/TEI/teiHeader/fileDesc/sourceDesc/biblStruct/analytic/author">
                <xsl:value-of select="/TEI/teiHeader/fileDesc/sourceDesc/biblStruct/analytic/author"/>
            </xsl:when>
            <xsl:when test="/TEI/teiHeader/fileDesc/sourceDesc/biblStruct/monogr/author/persName/@key">
                <xsl:call-template name="getXtmName">
                    <xsl:with-param name="target" select="/TEI/teiHeader/fileDesc/sourceDesc/biblStruct/monogr/author/persName/@key"/>
                </xsl:call-template>
            </xsl:when>
            <xsl:when test="/TEI/teiHeader/fileDesc/sourceDesc/biblStruct/analytic/editor"/>
            <xsl:when test="/TEI/teiHeader/fileDesc/sourceDesc/biblStruct/monogr/editor"/>
            <xsl:otherwise>
                <xsl:value-of select="'unknown'"/>
            </xsl:otherwise>
        </xsl:choose>
        </xsl:param>
        <xsl:if test="$author != ''">
            <xsl:value-of select="concat(normalize-space($author),'. ')"/>
        </xsl:if>
    </xsl:template>
    
    <xsl:template name="get-sourceDesc-editor-analytic">
        
        <xsl:param name="editor">
            <xsl:choose>
                <xsl:when test="/TEI/teiHeader/fileDesc/sourceDesc/biblStruct/analytic/editor/persName/@key">
                    <xsl:call-template name="getXtmName">
                        <xsl:with-param name="target" select="/TEI/teiHeader/fileDesc/sourceDesc/biblStruct/analytic/editor/persName/@key"/>
                    </xsl:call-template>
                </xsl:when>
                <xsl:when test="/TEI/teiHeader/fileDesc/sourceDesc/biblStruct/analytic/editor">
                    <xsl:value-of select="/TEI/teiHeader/fileDesc/sourceDesc/biblStruct/analytic/editor"/>
                </xsl:when>
                <!--
                <xsl:when test="/TEI/teiHeader/fileDesc/sourceDesc/biblStruct/monogr/editor/persName/@key">
                    <xsl:call-template name="getXtmName">
                        <xsl:with-param name="target" select="/TEI/teiHeader/fileDesc/editor/author/persName/@key"/>
                    </xsl:call-template>
                </xsl:when>
                -->
            </xsl:choose>
        </xsl:param>
        <xsl:if test="$editor != ''">
        <xsl:value-of select="concat(normalize-space($editor),', ed. ')"/>
        </xsl:if>
    </xsl:template>
    
    <xsl:template name="get-sourceDesc-editor-monogr">
        
        <xsl:param name="editor">
            <xsl:choose>
                <xsl:when test="/TEI/teiHeader/fileDesc/sourceDesc/biblStruct/monogr/editor/persName/@key">
                    <xsl:call-template name="getXtmName">
                        <xsl:with-param name="target" select="/TEI/teiHeader/fileDesc/sourceDesc/biblStruct/monogr/editor/persName/@key"/>
                        <xsl:with-param name='scope' select="'display'"/>
                    </xsl:call-template>
                </xsl:when>
                <xsl:when test="/TEI/teiHeader/fileDesc/sourceDesc/biblStruct/monogr/editor">
                    <xsl:value-of select="/TEI/teiHeader/fileDesc/sourceDesc/biblStruct/monogr/editor"/>
                </xsl:when>
                <!--
                    <xsl:when test="/TEI/teiHeader/fileDesc/sourceDesc/biblStruct/monogr/editor/persName/@key">
                    <xsl:call-template name="getXtmName">
                    <xsl:with-param name="target" select="/TEI/teiHeader/fileDesc/editor/author/persName/@key"/>
                    </xsl:call-template>
                    </xsl:when>
                -->
            </xsl:choose>
        </xsl:param>
        <xsl:if test="$editor != ''">
            <xsl:value-of select="concat('Ed. ',normalize-space($editor),'. ')"/>
        </xsl:if>
    </xsl:template>
    
    
    
    
    <xsl:template name="get-sourceDesc-title-analytic">
            <xsl:param name="title">
                <xsl:choose>
                    <xsl:when test="/TEI/teiHeader/fileDesc/sourceDesc/biblStruct/analytic/title/choice/reg">
                        <xsl:value-of select="normalize-space(/TEI/teiHeader/fileDesc/sourceDesc/biblStruct/analytic/title/choice/reg)"/>
                    </xsl:when>
                    <xsl:when test="/TEI/teiHeader/fileDesc/sourceDesc/biblStruct/analytic/title">
                        <xsl:value-of select="normalize-space(/TEI/teiHeader/fileDesc/sourceDesc/biblStruct/analytic/title)"/>
                    </xsl:when>
                </xsl:choose>
            </xsl:param>
            <xsl:choose>
                <xsl:when test="/TEI/teiHeader/fileDesc/sourceDesc/biblStruct/analytic/title/@level = 'm'">
                    <cite><xsl:value-of select="$title"/>.</cite><xsl:value-of select="' '"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="concat('“',$title,'.” ')"/>
                </xsl:otherwise>
            </xsl:choose>
    </xsl:template>
    <xsl:template name="get-sourceDesc-title-monogr">
        <xsl:choose>
            <xsl:when test="/TEI/teiHeader/fileDesc/sourceDesc/biblStruct/monogr/title/choice/reg">
                <cite><xsl:value-of select="concat(normalize-space(/TEI/teiHeader/fileDesc/sourceDesc/biblStruct/monogr/title/choice/reg),'. ')"/></cite>
            </xsl:when>
            <xsl:when test="/TEI/teiHeader/fileDesc/sourceDesc/biblStruct/monogr/title">
                <xsl:for-each select="/TEI/teiHeader/fileDesc/sourceDesc/biblStruct/monogr/title">
                <!-- this doesn't work with more than one title, e.g.,:
                    <monogr>
                    <author>Adams, Antoníeta</author>
                    <title>El Proyecto Crack</title>
                    <title type="sub">Cuentos Grises</title>
                    <imprint>
                    <pubPlace>Concepción, Chile</pubPlace>
                    <publisher>Ediciones Letra Nueva</publisher>
                    <date when="2005">2005</date>
                    </imprint>
                    </monogr>
                 -->
                    
                <cite><xsl:value-of select="concat(normalize-space(.),'. ')"/></cite>
                </xsl:for-each>
                
            </xsl:when>
        </xsl:choose>
    </xsl:template>
    <xsl:template name="get-sourceDesc-extent">
        <xsl:param name="extent" select="normalize-space(/TEI/teiHeader/fileDesc/sourceDesc/biblStruct/monogr/extent)"/>
        <xsl:if test="$extent != ''">
            <xsl:choose>
                <xsl:when test="ends-with($extent,'.')">
                    <xsl:value-of select="concat($extent,' ')"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="concat($extent,'. ')"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:if>
    </xsl:template>
    <xsl:template name="get-sourceDesc-pubPlace">
        <xsl:if test="/TEI/teiHeader/fileDesc/sourceDesc/biblStruct/monogr/imprint/pubPlace">
            <xsl:value-of select="concat(normalize-space(/TEI/teiHeader/fileDesc/sourceDesc/biblStruct/monogr/imprint/pubPlace),': ')"/>
        </xsl:if>
    </xsl:template>
    <xsl:template name="get-sourceDesc-publisher">
        <xsl:if test="/TEI/teiHeader/fileDesc/sourceDesc/biblStruct/monogr/imprint/publisher">
            <xsl:value-of select="concat(normalize-space(/TEI/teiHeader/fileDesc/sourceDesc/biblStruct/monogr/imprint/publisher),', ')"/>
        </xsl:if>
    </xsl:template>
    <xsl:template name="get-sourceDesc-date">
        <xsl:if test="/TEI/teiHeader/fileDesc/sourceDesc/biblStruct/monogr/imprint/date/@when">
            <xsl:value-of select="concat(normalize-space(/TEI/teiHeader/fileDesc/sourceDesc/biblStruct/monogr/imprint/date/@when),'. ')"/>
        </xsl:if>
    </xsl:template>
    <xsl:template name="get-sourceDesc-biblScope">
        <xsl:if test="/TEI/teiHeader/fileDesc/sourceDesc/biblStruct/monogr/imprint/biblScope[@type = 'vol']">
            <xsl:choose>
                <xsl:when test="/TEI/teiHeader/fileDesc/sourceDesc/biblStruct/monogr/imprint/biblScope[@type = 'pp']">
                    <xsl:value-of select="concat(normalize-space(/TEI/teiHeader/fileDesc/sourceDesc/biblStruct/monogr/imprint/biblScope[@type = 'vol']),': ')"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="concat(normalize-space(/TEI/teiHeader/fileDesc/sourceDesc/biblStruct/monogr/imprint/biblScope[@type = 'vol']),'. ')"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:if>
        <xsl:if test="/TEI/teiHeader/fileDesc/sourceDesc/biblStruct/monogr/imprint/biblScope[@type = 'pp']">
            <xsl:value-of select="concat(normalize-space(/TEI/teiHeader/fileDesc/sourceDesc/biblStruct/monogr/imprint/biblScope[@type = 'pp']),'. ')"/>
        </xsl:if>
    </xsl:template>
    
    <xsl:template name="get-sourceDesc-origPubInfo">
        <xsl:param name="pubPlace" select="normalize-space(/TEI/teiHeader/fileDesc/sourceDesc/biblStruct/relatedItem[@type = 'original_collection']/biblStruct/monogr/imprint/pubPlace)"/>
        <xsl:param name="publisher" select="normalize-space(/TEI/teiHeader/fileDesc/sourceDesc/biblStruct/relatedItem[@type = 'original_collection']/biblStruct/monogr/imprint/publisher)"/>
        <xsl:param name="date" select="normalize-space(/TEI/teiHeader/fileDesc/sourceDesc/biblStruct/relatedItem[@type = 'original_collection']/biblStruct/monogr/imprint/date/@when)"/>
        <xsl:if test="$pubPlace != '' and $publisher != '' and $date != ''">
            <xsl:value-of select="concat($pubPlace,': ',$publisher,', ',$date,'.')"/>
        </xsl:if>
    </xsl:template>
        
    
</xsl:stylesheet>
