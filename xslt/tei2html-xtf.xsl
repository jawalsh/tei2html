
<!--
   Copyright (c) 2005, Regents of the University of California
   All rights reserved.
 
   Redistribution and use in source and binary forms, with or without 
   modification, are permitted provided that the following conditions are 
   met:

   - Redistributions of source code must retain the above copyright notice, 
     this list of conditions and the following disclaimer.
   - Redistributions in binary form must reproduce the above copyright 
     notice, this list of conditions and the following disclaimer in the 
     documentation and/or other materials provided with the distribution.
   - Neither the name of the University of California nor the names of its
     contributors may be used to endorse or promote products derived from 
     this software without specific prior written permission.

   THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" 
   AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE 
   IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE 
   ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE 
   LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR 
   CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF 
   SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS 
   INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN 
   CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) 
   ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE 
   POSSIBILITY OF SUCH DAMAGE.
-->


<xsl:stylesheet xpath-default-namespace="http://www.tei-c.org/ns/1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
  xmlns:xs="http://www.w3.org/2001/XMLSchema" 
  xmlns:eg="http://www.tei-c.org/ns/Examples"
  xmlns:xtf="http://cdlib.org/xtf"
  xmlns:xdoc="http://www.pnp-software.com/XSLTdoc" exclude-result-prefixes="#all"
  xmlns:fn="http://www.w3.org/2005/xpath-functions"
  xmlns:session="java:org.cdlib.xtf.xslt.Session"
  xmlns="http://www.w3.org/1999/xhtml">
  
<xsl:param name="hitCount" select="/TEI/@xtf:hitCount"/>

<!-- docFormatterCommon: start -->
<xsl:param name="root.path"/>
<xsl:param name="servlet.path"/>
<xsl:param name="xtfURL" select="$root.path"/>
<xsl:param name="icon.path" select="concat($xtfURL, 'icons/default/')"/>
<xsl:param name="dynaxmlPath" select="if (matches($servlet.path, 'org.cdlib.xtf.crossQuery.CrossQuery')) then 'org.cdlib.xtf.dynaXML.DynaXML' else 'view'"/>
<xsl:param name="docId"/>
<xsl:param name="docPath" select="replace($docId, '[A-Za-z0-9]+\.xml$', '')"/>
<xsl:param name="source" select="''"/>
<xsl:param name="anchor.id" select="'0'"/>
<xsl:param name="set.anchor" select="'0'"/>
<!-- To support direct links from snippets, the following two parameters must check value of $hit.rank -->
<xsl:param name="chunkId">
    <xsl:choose>
      <xsl:when test="$hit.rank != '0' and key('hit-rank-dynamic', $hit.rank)/ancestor::*[matches(name(),'^div')]">
        <xsl:value-of select="key('hit-rank-dynamic', $hit.rank)/ancestor::*[matches(name(),'^div')][1]/@*[local-name()='id']"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="'0'"/>
      </xsl:otherwise>
    </xsl:choose>
</xsl:param>
<xsl:param name="brand" select="'default'"/>
<xsl:param name="xtfBar" as="xs:boolean" select="false()"/>
  
<!-- search parameters -->
  
<xsl:param name="query"/>
<xsl:param name="query-join"/>
<xsl:param name="query-exclude"/>
<xsl:param name="sectionType"/>
<xsl:param name="smode"/>
  
<xsl:param name="apos"><xsl:value-of><xsl:text>'</xsl:text></xsl:value-of></xsl:param>
  
<xsl:key name="hit-num-dynamic" match="xtf:hit" use="@hitNum"/>
<xsl:key name="div-id" match="*[matches(name(),'^div')]" use="@*[local-name()='id']"/>
  
<xsl:variable name="sourceStr">
    <xsl:if test="$source">;source=<xsl:value-of select="$source"/></xsl:if>
  </xsl:variable>
  
  <xsl:param name="query.string" select="concat('docId=', $docId, $sourceStr)"/>
  
  <xsl:param name="doc.path"><xsl:value-of select="$xtfURL"/><xsl:value-of select="$dynaxmlPath"/>?<xsl:value-of select="$query.string"/></xsl:param>
  
  <xsl:variable name="systemId" select="saxon:systemId()" xmlns:saxon="http://saxon.sf.net/"/>
  
  <xsl:param name="doc.dir">
    <xsl:choose>
      <xsl:when test="starts-with($systemId, 'http://')">
        <xsl:value-of select="replace($systemId, '/[^/]*$', '')"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="concat($xtfURL, 'data/', $docPath)"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:param>
  
  <!-- from teiDocFormatter.xsl -->
  <xsl:param name="hit.rank">
    <xsl:choose>
      <xsl:when test="$query and not($query = '0')">
        <xsl:value-of select="key('hit-num-dynamic', '1')/@rank"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="'0'"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:param>
  
  <!-- ====================================================================== -->
  <!-- Anchor Template                                                        -->
  <!-- ====================================================================== -->
  
  <xsl:template name="create.anchor">
    <xsl:choose>
      <xsl:when test="($query != '0' and $query != '') and $hit.rank != '0'">
        <xsl:text>#</xsl:text><xsl:value-of select="key('hit-rank-dynamic', $hit.rank)/@hitNum"/>
      </xsl:when>
      <xsl:when test="($query != '0' and $query != '') and $set.anchor != '0'">
        <xsl:text>#</xsl:text><xsl:value-of select="$set.anchor"/>
      </xsl:when>
      <xsl:when test="($query != '0' and $query != '') and $chunkId != '0'">
        <xsl:text>#</xsl:text><xsl:value-of select="key('div-id', $chunkId)/@xtf:firstHit"/>
      </xsl:when>
      <xsl:when test="$anchor.id != '0'">
        <xsl:text>#X</xsl:text>
      </xsl:when>
    </xsl:choose>
  </xsl:template>
  
<!-- docFormatterCommon: end -->
  
<xsl:variable name="brand.header"/>


<!-- key: added from default docFormatter.xsl by jawalsh -->
<xsl:key name="hit-rank-dynamic" match="xtf:hit" use="@rank"/>

<!-- Search Hits -->


<xsl:template match="xtf:hit">
  <a>
    <xsl:attribute name="id">
      <xsl:value-of select="concat('hitRank_',@rank)"/>
    </xsl:attribute>
    </a>
  <a>
    <xsl:attribute name="id">
      <xsl:value-of select="concat('hitNum_',@hitNum)"/>
      </xsl:attribute>
  </a>
  <xsl:if test="@hitNum != 1">
  <xsl:call-template name="prev.hit"/>
  </xsl:if>
  

  <xsl:choose>
    <xsl:when test="xtf:term">
      <span class="hitsection">
        <xsl:apply-templates/>
      </span>
    </xsl:when>
    <xsl:otherwise>
      <span class="hit">
          <xsl:apply-templates/>
      </span>
    </xsl:otherwise>
  </xsl:choose>

 <!-- <xsl:if test="not(@more='yes')"> -->
  <xsl:if test="@hitNum != $hitCount and not(@more='yes')">
    <xsl:call-template name="next.hit"/>
  </xsl:if>

</xsl:template>

<xsl:template match="xtf:more">

  <span class="hitsection">
    <xsl:apply-templates/>
  </span>

  <xsl:if test="@hitNum != $hitCount and not(@more='yes')">
    <xsl:call-template name="next.hit"/>
  </xsl:if>

</xsl:template>

<xsl:template match="xtf:term">
  <!--<xsl:if test="parent::xtf:hit">-->
    <span class="subhit">
      <xsl:apply-templates/>
    </span>
  <!--</xsl:if>-->
</xsl:template>

<!-- rather than use div1 here could we use a construct like that employed for the navigation arrows -->

<xsl:template name="prev.hit">

  <xsl:variable name="num" select="@hitNum"/>
  <xsl:variable name="prev" select="$num - 1"/>

    
      <span class="jslink">
        <xsl:attribute name="onclick">
          <xsl:value-of select="concat('jumpToAnchor(',$apos,'hitNum_',$prev,$apos,')')"/>
        </xsl:attribute>
        <img src="{$icon.path}b_inprev.gif" alt="previous hit"/>
      </span><xsl:text>&#x00a0;</xsl:text></xsl:template>

<xsl:template name="next.hit">

  <xsl:variable name="num" select="@hitNum"/>
  <xsl:variable name="next" select="$num + 1"/>
 <xsl:text>&#x00a0;</xsl:text><span class="jslink">
   <xsl:attribute name="onclick">
     <xsl:value-of select="concat('jumpToAnchor(',$apos,'hitNum_',$next,$apos,')')"/>
   </xsl:attribute>
        
        <img src="{$icon.path}b_innext.gif" alt="next hit"/>
      </span>
  
</xsl:template>
  
<xsl:template match="xtf:snippets|xtf:meta"/>
  <!-- 
  <xsl:template name="bbar">
        <div class="bbar">
          <table border="0" cellpadding="0" cellspacing="0">
            <tr>
              <td colspan="3" align="center">
                <xsl:copy-of select="$brand.header"/>
              </td>
            </tr>
            <tr>
              <td class="left">
                <a href="{$xtfURL}search">Home</a><xsl:text> | </xsl:text>
                <xsl:choose>
                  <xsl:when test="session:getData('queryURL')">
                    <a href="{session:getData('queryURL')}">Return to Search Results</a>
                  </xsl:when>
                  <xsl:otherwise>
                    <span class="notActive">Return to Search Results</span>
                  </xsl:otherwise>
                </xsl:choose>
              </td>
              <td width="34%" class="center">
                <form action="{$xtfURL}{$dynaxmlPath}" method="get">
                  <input name="query" type="text" size="15"/>
                  <input type="hidden" name="docId" value="{$docId}"/>
                  <input type="hidden" name="chunkId" value="{$chunkId}"/>
                  <input type="submit" value="Search this Book"/>
                  <input type="hidden" name="smode" value="within"/>
                </form>
              </td>
            </tr>
          </table>
        </div>
  </xsl:template>
  -->
  
  <xsl:template name="xtfBar">
    <div id="xtfBar">
      <xsl:call-template name="returnResults"/>
      <xsl:call-template name="searchWithin"/>
    </div>
    
  </xsl:template>
  <xsl:template name="searchWithin">
    <div id="searchWithin">
      <span class="searchWithinHead">Search within this document:<br/></span>
      <!--
      <form action="{$xtfURL}{$dynaxmlPath}" method="get">
        <div>
        <input name="query" type="text" size="29"/>
        <input type="hidden" name="docId" value="{$docId}"/>
        <input type="hidden" name="chunkId" value="{$chunkId}"/>
        <input class="submit" type="submit" value="Go!"/>
        <input type="hidden" name="smode" value="within"/>
        </div>
      </form>
      -->
      <form onsubmit="return false;">
        <div>
          <input name="query" type="text" size="29" onkeypress="loadPanelsOnReturn(event,this.form)"/>
          <input type="hidden" name="docId" value="{$docId}"/>
          <input type="hidden" name="chunkId" value="{$chunkId}"/>
          <input class="submit" type="button" value="Go!" onclick="loadPanels(this.form);this.form.query.value = '';"/>
          <input type="hidden" name="smode" value="within"/>
        </div>
      </form>
      <xsl:if test="$query != ''">
        <xsl:call-template name="hitSummary"/>
      </xsl:if>
    </div>
  </xsl:template> 
  
  <xsl:template name="returnResults">
    <div id="returnResults">
    <xsl:if test="session:getData('queryURL')">
        <a href="{session:getData('queryURL')}">&lt;&lt; Back to Search Results</a>
    </xsl:if>
    </div>
  </xsl:template>
  
  
  <xsl:template name="hitSummary" exclude-result-prefixes="#all">
    
    <xsl:variable name="sum">
      <xsl:choose>
        <xsl:when test="($query != '0') and ($query != '')">
          <xsl:value-of select="number(/*/@xtf:hitCount)"/>
        </xsl:when>
        <xsl:otherwise>0</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="occur">
      <xsl:choose>
        <xsl:when test="$sum != 1">occurrences</xsl:when>
        <xsl:otherwise>occurrence</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    
    <div id="hitSummary">
      <span class="hit-count">
        <xsl:value-of select="$sum"/>
      </span>
      <xsl:text>&#160;</xsl:text>
      <xsl:value-of select="$occur"/>
      <xsl:text> of </xsl:text>
      <span class="hit-query">
        <xsl:value-of select="$query"/>
      </span><xsl:value-of select="'&#160;'"/>
      <!-- [<a href="{$doc.path};chunkId={$chunkId};brand={$brand}">Clear Hits</a>] -->
      [<a>
        <xsl:attribute name="href">
          <xsl:value-of select="concat('javascript:loadPanel(',$apos,'doc-panel',$apos,',',$apos)"/>
          <xsl:value-of select="$xtfURL"/>
          <xsl:value-of select="concat($dynaxmlPath,'?')"/>
          <xsl:value-of select="$query.string"/>
          <xsl:value-of select="concat(';outputAsDiv=true',$apos,');')"/>
          <xsl:value-of select="concat('loadPanel(',$apos,'xtfBar-panel',$apos,',',$apos)"/>
          <xsl:value-of select="$xtfURL"/>
          <xsl:value-of select="concat($dynaxmlPath,'?')"/>
          <xsl:value-of select="$query.string"/>
          <xsl:value-of select="concat(';xtfBar=true',$apos,')')"/>
        </xsl:attribute>
        <xsl:value-of select="'Clear Hits'"/>
      </a>]
    </div>
    
  </xsl:template>
  
  <xsl:template name="toc">
    <div id="container"/>
  </xsl:template>
  
 

  
  
</xsl:stylesheet>
