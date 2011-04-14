
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
  xmlns:xdoc="http://www.pnp-software.com/XSLTdoc" xmlns:xtf="http://cdlib.org/xtf" exclude-result-prefixes="#all"
  xmlns:fn="http://www.w3.org/2005/xpath-functions">
  
<xsl:param name="icon.path" select="concat($xtfURL, 'icons/default/')"/>
<xsl:param name="hitCount" select="/TEI.2/@xtf:hitCount"/>


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

    
      <a>
        <xsl:attribute name="href">
          <xsl:text>#</xsl:text><xsl:value-of select="concat('hitNum_',$prev)"/>
        </xsl:attribute>
        <img src="{$icon.path}b_inprev.gif" border="0" alt="previous hit"/>
      </a><xsl:text>&#x00a0;</xsl:text></xsl:template>

<xsl:template name="next.hit">

  <xsl:variable name="num" select="@hitNum"/>
  <xsl:variable name="next" select="$num + 1"/>
 <xsl:text>&#x00a0;</xsl:text><a>
        <xsl:attribute name="href">
          <xsl:text>#</xsl:text><xsl:value-of select="concat('hitNum_',$next)"/>
        </xsl:attribute>
        
        <img src="{$icon.path}b_innext.gif" border="0" alt="next hit"/>
      </a>
  
</xsl:template>
  


</xsl:stylesheet>
