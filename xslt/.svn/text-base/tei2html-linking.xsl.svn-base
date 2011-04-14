<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xpath-default-namespace="http://www.tei-c.org/ns/1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
  xmlns:xs="http://www.w3.org/2001/XMLSchema" 
  xmlns:eg="http://www.tei-c.org/ns/Examples"
  xmlns:xtm="http://www.topicmaps.org/xtm/" 
  xmlns:xdoc="http://www.pnp-software.com/XSLTdoc" exclude-result-prefixes="#all"
  xmlns:fn="http://www.w3.org/2005/xpath-functions"
  xmlns="http://www.w3.org/1999/xhtml">

  <xdoc:doc type="stylesheet">
    <xdoc:author>John A. Walsh</xdoc:author>
    <xdoc:copyright>Copyright 2006 John A. Walsh</xdoc:copyright>
    <xdoc:short>XSLT stylesheet to transform TEI P5 documents to XHTML.</xdoc:short>
  </xdoc:doc>

  <xsl:template match="ref|ptr">
    <xsl:variable name="target">
      <xsl:value-of select="@target"/>
    </xsl:variable>
    <xsl:choose>
      <xsl:when test="starts-with($target,'#')">
        <xsl:choose>
          <xsl:when test="$enableMouseoverNotes = true()">
            <xsl:choose>
              <xsl:when test="$xtf = true()">
                <span class="tooltip">
                  <xsl:attribute name="class" select="concat('showTip ',substring-after($target,'#'))"/>
                <span>
                  <xsl:attribute name="onclick" select="concat('jumpToAnchor(',$apos,substring-after($target,'#'),$apos,')')"/>
                  <xsl:call-template name="rendition">
                    <xsl:with-param name="defaultRend">
                      <xsl:value-of select="'jslink ref'"/>
                    </xsl:with-param>
                  </xsl:call-template>
                  <xsl:call-template name="id"/>
                    <xsl:choose>
                      <xsl:when test="not(text()[normalize-space(.)] | *)">
                        <xsl:value-of select="$refSymbol"/>
                      </xsl:when>
                      <xsl:otherwise>
                        <xsl:apply-templates/>
                      </xsl:otherwise>
                    </xsl:choose>
                </span>
                </span>
              </xsl:when>
              <xsl:otherwise>
            <a href="{$target}">
              <xsl:call-template name="rendition">
                <xsl:with-param name="defaultRend">
                  <xsl:value-of select="'tooltip ref'"/>
                </xsl:with-param>
              </xsl:call-template>
              <xsl:call-template name="id"/>
                <xsl:choose>
                  <xsl:when test="not(text()[normalize-space(.)] | *)">
                    <xsl:value-of select="$refSymbol"/>
                  </xsl:when>
                  <xsl:otherwise>
                    <xsl:apply-templates/>
                  </xsl:otherwise>
                </xsl:choose>
            </a>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:when>
          <xsl:otherwise>
            <a>
              <xsl:call-template name="id"/>
              <xsl:call-template name="rendition">
                <xsl:with-param name="defaultRend">
                  <xsl:value-of select="'ref'"/>
                </xsl:with-param>
              </xsl:call-template>
              <xsl:attribute name="href">
                <xsl:value-of select="$target"/>
              </xsl:attribute>
              <xsl:choose>
                <xsl:when test="not(text()[normalize-space(.)] | *)">
                  <xsl:value-of select="$refSymbol"/>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:apply-templates/>
                </xsl:otherwise>
              </xsl:choose>
            </a>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>
      <xsl:otherwise>
        <!-- 
          brackets moved to css
        <xsl:if test="@rend='bracket'">
          <xsl:text>&lt;</xsl:text>
        </xsl:if>
        -->
        <a>
          <xsl:call-template name="rendition"/>
          <xsl:attribute name="href">
            <xsl:value-of select="$target"/>
          </xsl:attribute>
          <xsl:choose>
            <xsl:when test="name() = 'ref'">
              <xsl:apply-templates/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="$target"/>
            </xsl:otherwise>
          </xsl:choose>
        </a>
        <!-- 
          brackets moved to css
        <xsl:if test="@rend='bracket'">
          <xsl:text>&gt;</xsl:text>
        </xsl:if>
        -->
      </xsl:otherwise>
    </xsl:choose>

  </xsl:template>
  
  <xsl:template match="note//ref|note//ptr">
    <xsl:variable name="target">
      <xsl:value-of select="@target"/>
    </xsl:variable>
    <xsl:choose>
      <xsl:when test="starts-with($target,'#')">
        <xsl:choose>
          <xsl:when test="$xtf = true()">
            <span>
              <xsl:attribute name="onclick" select="concat('jumpToAnchor(',$apos,substring-after($target,'#'),$apos,')')"/>
              <xsl:call-template name="id"/>
              <xsl:call-template name="rendition">
                <xsl:with-param name="defaultRend">
                  <xsl:value-of select="'jslink'"/>
                </xsl:with-param>
              </xsl:call-template>
              <!--
              <xsl:attribute name="href">
                <xsl:value-of select="$target"/>
              </xsl:attribute>
              -->
              <xsl:choose>
                <xsl:when test="not(text()[normalize-space(.)] | *)">
                  <xsl:value-of select="$refSymbol"/>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:apply-templates/>
                </xsl:otherwise>
              </xsl:choose>
            </span>
          </xsl:when>
          <xsl:otherwise>
            <a>
              <xsl:call-template name="id"/>
              <xsl:call-template name="rendition">
                <xsl:with-param name="defaultRend">
                  <xsl:value-of select="'ref'"/>
                </xsl:with-param>
              </xsl:call-template>
              <xsl:attribute name="href">
                <xsl:value-of select="$target"/>
              </xsl:attribute>
              <xsl:choose>
                <xsl:when test="not(text()[normalize-space(.)] | *)">
                  <xsl:value-of select="$refSymbol"/>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:apply-templates/>
                </xsl:otherwise>
              </xsl:choose>
            </a>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>
      <xsl:otherwise>
        <a>
          <xsl:call-template name="id"/>
          <xsl:call-template name="rendition"/>
          <xsl:attribute name="href">
            <xsl:value-of select="$target"/>
          </xsl:attribute>
          <xsl:choose>
            <xsl:when test="name() = 'ref'">
              <xsl:apply-templates/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="$target"/>
            </xsl:otherwise>
          </xsl:choose>
        </a>
      </xsl:otherwise>
    </xsl:choose>
    
  </xsl:template>

  <!-- For refs, like in footnotes, without links back -->
  <xsl:template match="ref[not(@target)]" priority="9">
    <span>
      <xsl:call-template name="atts"/>
      <xsl:apply-templates/>
    </span>
  </xsl:template>
  
  <xsl:template match="ref[@type = 'simple']">
    <xsl:param name="target" select="@target"/>
    <xsl:choose>
      <xsl:when test="$xtf = true()">
    <span>
      <xsl:attribute name="onclick" select="concat('jumpToAnchor(',$apos,substring-after($target,'#'),$apos,')')"/>
      <xsl:call-template name="id"/>
      <xsl:call-template name="rendition">
        <xsl:with-param name="defaultRend">
          <xsl:value-of select="'jslink'"/>
        </xsl:with-param>
      </xsl:call-template>
      <xsl:choose>
        <xsl:when test="not(text()[normalize-space(.)] | *)">
          <xsl:value-of select="$refSymbol"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:apply-templates/>
        </xsl:otherwise>
      </xsl:choose>
    </span>
      </xsl:when>
      <xsl:otherwise>
        <a>
          <xsl:call-template name="id"/>
          <xsl:call-template name="rendition"/>
          <xsl:attribute name="href">
            <xsl:value-of select="$target"/>
          </xsl:attribute>
          <xsl:choose>
            <xsl:when test="name() = 'ref'">
              <xsl:apply-templates/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="$target"/>
            </xsl:otherwise>
          </xsl:choose>
        </a>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  

  <xsl:template match="ptr[@type = 'tm']">
    <xsl:param name="target">
      <xsl:value-of select="substring-after(@target,'#')"/>
    </xsl:param>

    <span onmouseout="hideTip()">
      <xsl:call-template name="rendition">
        <xsl:with-param name="defaultRend">
          <xsl:value-of select="'tooltip'"/>
        </xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="id"/>
      <xsl:attribute name="onmouseover">
        <xsl:text>doTooltip(event,document.getElementById("</xsl:text>
        <xsl:value-of select="$target"/>
        <xsl:text>").innerHTML)</xsl:text>
      </xsl:attribute>
      <xsl:value-of select="$refSymbol"/>
    </span>
    <xsl:apply-templates select="$xtm//xtm:topic[@id = $target]"/>
  </xsl:template>
  
  <xsl:template match="ptr[@type = 'annotation']">
    <xsl:param name="noteId" select="substring-after(@target,'#')"/>
    <xsl:variable name="metaFile" select="document(concat($dataRoot,substring-before(@target,'#')))"/>

    <span>
      <xsl:attribute name="class" select="concat('showTip ',$noteId)"/>
      <span>
        <xsl:call-template name="id"/>
        <xsl:call-template name="rend"/>
        <xsl:call-template name="rendition">
          <xsl:with-param name="defaultRend" select="'ref'"/>
        </xsl:call-template>
        <xsl:value-of select="$refSymbol"/>
      </span>
    </span>
    <xsl:apply-templates select="$metaFile//note[@xml:id = $noteId]"/>
  </xsl:template>
  



  <xsl:template match="ptr[@type = 'gloss']">
    <xsl:param name="target">
      <xsl:value-of select="substring-after(@target,'#')"/>
    </xsl:param>
    <span>
      <xsl:attribute name="class" select="concat('showTip ',$target)"/>
    <span>
      <xsl:call-template name="id"/>
      <xsl:call-template name="rend"/>
      <xsl:call-template name="rendition">
        <xsl:with-param name="defaultRend" select="'ref'"/>
      </xsl:call-template>
      <xsl:value-of select="$refSymbol"/>
    </span>
    </span>

    <xsl:apply-templates select="$glossary//entry[@xml:id = $target]"/>

  </xsl:template>

  <xsl:template match="ptr[@type = 'xnote']">
    <xsl:param name="file">
      <xsl:value-of select="substring-before(@target,'#')"/>
    </xsl:param>
    <xsl:param name="target">
      <xsl:value-of select="substring-after(@target,'#')"/>
    </xsl:param>

    <span onmouseout="hideTip()">
      <xsl:call-template name="rendition">
        <xsl:with-param name="defaultRend">
          <xsl:value-of select="'tooltip'"/>
        </xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="id"/>
      <xsl:attribute name="onmouseover">
        <xsl:text>doTooltip(event,document.getElementById("</xsl:text>
        <xsl:value-of select="$target"/>
        <xsl:text>").innerHTML)</xsl:text>
      </xsl:attribute>
      <xsl:value-of select="$refSymbol"/>
    </span>

    <xsl:apply-templates
      select="document(concat('file://',$dataRoot,$file))//note[@xml:id = $target]" mode="hide"/>

  </xsl:template>



</xsl:stylesheet>
