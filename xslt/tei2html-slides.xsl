<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xpath-default-namespace="http://www.tei-c.org/ns/1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
	xmlns:xs="http://www.w3.org/2001/XMLSchema" 
	xmlns:eg="http://www.tei-c.org/ns/Examples"
	xmlns:xdoc="http://www.pnp-software.com/XSLTdoc" exclude-result-prefixes="#all"
	xmlns:fn="http://www.w3.org/2005/xpath-functions"
	xmlns="http://www.w3.org/1999/xhtml">
	
	<xsl:import href="tei2html.xsl"/>
	
	<xdoc:doc type="stylesheet">
		<xdoc:author>John A. Walsh</xdoc:author>
		<xdoc:copyright>Copyright 2006 John A. Walsh</xdoc:copyright>
		<xdoc:short>XSLT stylesheet to transform TEI P5 documents to XHTML.</xdoc:short>
	</xdoc:doc>
	<!-- naming conventions:
		
		named templates:
		parameters that indicate option material in output use "include...", e.g., "includeDocumentInformation"
		
	-->

	

	
<xsl:output
  method="xml"
  doctype-public="-//W3C//DTD XHTML 1.1//EN"
  doctype-system="xhtml11-flat.dtd"
  cdata-section-elements="script xsl:comment"
  indent="no"/> 
	

	<xsl:param name="cssFile">css/tei2html-slides.css</xsl:param> 
        <xsl:param name="standalone" as="xs:boolean"><xsl:value-of select="false()"/></xsl:param>
	<xsl:param name="notesCssFile">css/tei2html-slides-notes.css</xsl:param>
	<xsl:param name="cssSecondaryFile"/>
	<xsl:param name="numberHeadings"></xsl:param>
	<xsl:param name="splitLevel">0</xsl:param>
	<xsl:param name="subTocDepth">-1</xsl:param>
	<xsl:param name="topNavigationPanel"/>
	<xsl:param name="bottomNavigationPanel"/>
	<xsl:param name="linkPanel"></xsl:param>
	<xsl:param name="speakingNotesFileName">notes.html</xsl:param>
	<!-- <xsl:template name="copyrightStatement"/> -->
	<xsl:param name="makingSlides" as="xs:boolean">true</xsl:param>
	<xsl:param name="numberTables"/>
	<!-- for slides -->
	<xsl:param name="inputName"/>
	<xsl:param name="processor"/>
	<xsl:param name="includePrevNextPanel" as="xs:boolean"><xsl:value-of select="false()"/></xsl:param>
	<xsl:param name="outputDir"/>
	<xsl:param name="verbose"/>

	<xsl:param name="inputFileName">
		<xsl:value-of select="$inputName"/>
	</xsl:param>
	
	<xsl:param name="outputFile">
		<xsl:choose>
			<xsl:when test="$inputFileName =''">index-slides</xsl:when>
			<xsl:when test="contains($inputFileName,'.xml')"><xsl:value-of select="substring-before($inputFileName,'.xml')"/>-slides</xsl:when>
			<xsl:otherwise><xsl:value-of select="$inputFileName"/>-slides</xsl:otherwise>
		</xsl:choose>
	</xsl:param>
	
	<xsl:template match="div" mode="genid">
		<xsl:value-of select="$outputFile"/><xsl:number/>
	</xsl:template>
	
	<xsl:template match="docAuthor">
		<div class="docAuthor"><xsl:apply-templates/></div>
	</xsl:template>
	
	<xsl:template match="docDate">
		<div class="docDate"><xsl:apply-templates/></div>
	</xsl:template>
	
	<!-- use p in tei2html.xsl 
	<xsl:template match="p">
		<p>
			<xsl:if test="@rend">
				<xsl:choose>
					<xsl:when test="@rend='rtl'">
						<xsl:attribute name="dir">rtl</xsl:attribute>
					</xsl:when>
					<xsl:when test="@rend='RTL'">
						<xsl:attribute name="dir">rtl</xsl:attribute>
					</xsl:when>
					<xsl:otherwise>
						<xsl:attribute name="class"><xsl:value-of select="./@rend"/></xsl:attribute>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:if>
		<xsl:apply-templates/></p>
	</xsl:template>
	-->
	
	<xsl:template match="/">
		<xsl:call-template name="speakingNotesMaster"/>
		<xsl:apply-templates select="TEI"/>
	</xsl:template>
	
	<xsl:template match="/TEI">
		<xsl:param name="slidenum">
		<xsl:value-of select="$outputFile"/>0</xsl:param>
		<xsl:call-template name="outputChunk">
			<xsl:with-param name="ident">
				<xsl:value-of select="$slidenum"/>
			</xsl:with-param>
			<xsl:with-param name="content">
				<xsl:call-template name="mainslide"/>
			</xsl:with-param>
		</xsl:call-template>
		<xsl:apply-templates select="text/body/div"/>
	</xsl:template>
	
	<!-- xref to previous and last slides -->
	<!--
		<xsl:template name="xrefpanel">
		<table class="slide" width="95%">
		<tr class="bottombar">
		<td align="left">
		<b><xsl:number/></b><xsl:text> </xsl:text>
		<xsl:if test="following-sibling::div">
		<xsl:variable name="next">
		<xsl:apply-templates select="following-sibling::div[1]" mode="genid"/>
		</xsl:variable>
		<a class="bottombar" href="{concat($next,'.html')}">Next | </a>
		</xsl:if>
		<xsl:variable name="first"><xsl:value-of select="$outputFile"/>0</xsl:variable>
		<a class="bottombar" href="{concat($first,'.html')}">First</a>
		<xsl:if test="preceding-sibling::div">
		<xsl:variable name="prev">
		<xsl:apply-templates select="preceding-sibling::div[1]" mode="genid"/>
		</xsl:variable>
		<a class="bottombar" href="{concat($prev,'.html')}">| Previous</a>
		</xsl:if>
		</td>
		<td align="right">
		<i>
		<xsl:call-template name="generateTitle"/>
		</i>
		</td></tr>
		</table>
		</xsl:template>
	-->
	<xsl:template name="prevnextpanel">
			<div class="navbar">
				<div style="width:50%;" class="prev">
					<xsl:choose>
					<xsl:when test="preceding-sibling::div">
						<xsl:variable name="prev">
							<xsl:apply-templates select="preceding-sibling::div[1]" mode="genid"/>
						</xsl:variable>
						<a class="navbar" href="{concat($prev,'.html')}">previous</a>
					</xsl:when>
						<xsl:otherwise><xsl:comment>Something doesn't like the empty div</xsl:comment></xsl:otherwise>
					</xsl:choose>
				</div>
				<div style="width:50%;" class="next">
					<!--
						<xsl:if test="following-sibling::div">
						<xsl:variable name="next">
						<xsl:apply-templates select="following-sibling::div[1]" mode="genid"/>
						</xsl:variable>
						<a class="navbar" href="{concat($next,'.html')}">next</a>
						</xsl:if>
					-->
					<xsl:choose>
						<xsl:when test="position() = last()">
							<xsl:variable name="first"><xsl:value-of select="$outputFile"/>0</xsl:variable>
							<a class="navbar" href="{concat($first,'.html')}">start</a>
						</xsl:when>
						<xsl:otherwise>
							<xsl:variable name="next">
								<xsl:apply-templates select="following-sibling::div[1]" mode="genid"/>
							</xsl:variable>
							<a class="navbar" href="{concat($next,'.html')}">next</a>
						</xsl:otherwise>
					</xsl:choose>
				</div>
			</div>
	</xsl:template>
	
	<xsl:template name="mainslide">
		<html>
<xsl:call-template name="htmlHead"/>
			<xsl:variable name="next"><xsl:value-of select="$outputFile"/>1</xsl:variable>
			<body>
<!-- no body onclick for mainslide -->
<!--
				<xsl:attribute name="onclick">
					<xsl:text>window.location='</xsl:text>
					<xsl:value-of select="concat($next,'.html')"/>
					<xsl:text>'</xsl:text>
				</xsl:attribute>
-->
				<div  class="navbar">
					<table class="slide" width="95%">
						<tr>
							<td align="left" style="width:50%;"/>
							<td align="right" style="width:50%;">
								
								<a class="navbar" href="{concat($next,'.html')}">start</a>
							</td>
						</tr>
					</table>
					<h1 class="maintitle">
						<xsl:call-template name="generateTitle"/>
					</h1>
					<xsl:apply-templates select="text/front//docAuthor"/>
					<xsl:apply-templates select="text/front//docDate"/>
					<div>
						<ul>
							<xsl:for-each select="text/body/div">
								<xsl:variable name="n"><xsl:value-of select="$outputFile"/><xsl:number/></xsl:variable>
								<li> <a href="{$n}.html"><xsl:value-of select="head"/></a></li>
							</xsl:for-each>
						</ul>
					</div>
					<hr class="bottombar"/>
					<table class="slide" width="95%">
						<tr>
							<td class='bottombar' align='left'><xsl:call-template name='copyrightStatement'/></td>
							<td class="bottombar" align="right">
								<xsl:call-template name="generateTitle"/>
						</td></tr>
					</table>
				</div>
			</body>
		</html>
	</xsl:template>
	
	
	<xsl:template match="body/div">
		<xsl:variable name="slidenum"><xsl:value-of select="$outputFile"/>
		<xsl:number/></xsl:variable>
		<xsl:call-template name="outputChunk">
			<xsl:with-param name="ident">
				<xsl:value-of select="$slidenum"/>
			</xsl:with-param>
			<xsl:with-param name="content">
				<xsl:call-template name="slideout"/>
			</xsl:with-param>
		</xsl:call-template>
		
	</xsl:template>
	
	<xsl:template name="slideout">
		<html>
			
 
			<xsl:call-template name="htmlHead"/>
			<body>
				<xsl:variable name="next">
					<xsl:apply-templates select="following-sibling::div[1]" mode="genid"/>
				</xsl:variable>
				<xsl:if test="$includePrevNextPanel != true()">
				<xsl:attribute name="onclick">
					<xsl:choose>
						<xsl:when test="position() = last()">
							<xsl:variable name="first"><xsl:value-of select="$outputFile"/>0</xsl:variable>
							<xsl:text>window.location='</xsl:text>
							<xsl:value-of select="concat($first,'.html')"/>
							<xsl:text>'</xsl:text>
						</xsl:when>
						<xsl:otherwise>
					<xsl:text>window.location='</xsl:text>
					<xsl:value-of select="concat($next,'.html')"/>
					<xsl:text>'</xsl:text>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:attribute>
				</xsl:if>
				<xsl:if test="$includePrevNextPanel = true()">
				<xsl:call-template name="prevnextpanel"/>
				</xsl:if>
				<div  class="teidiv">
					<xsl:if test="head">
					<h1 class="slidetitle"><xsl:apply-templates mode="plain" select="head" /></h1>
					</xsl:if>
					<hr class="topbar"/>
					<div class="slideBody">
						<xsl:apply-templates/>
					</div>
					<hr class="bottombar"/>
					<table width="95%"><tr><td class='bottombar' align='left'><xsl:call-template name='copyrightStatement'/></td><td class="bottombar" align="right"><xsl:call-template name="generateTitle"/></td></tr></table>
				</div>
			</body>
		</html>
	</xsl:template>
	
	<xsl:template name="speakingNotesMaster">
		<xsl:result-document encoding="utf-8"
									method="xml" doctype-public="-//W3C//DTD XHTML 1.1//EN" doctype-system="xhtml11-flat.dtd" href="{$speakingNotesFileName}">
			<html>
				
				<head><title>
				<xsl:text>Speaking Notes for "</xsl:text><call-template name="generateTitle"/><xsl:text>"</xsl:text>
				</title>
				<link rel="stylesheet" href="{$notesCssFile}" type="text/css" />
				</head>
				<body>
					<xsl:call-template name="speakingNotes"/>
				</body>
			</html>
		</xsl:result-document>
	</xsl:template>
	
	<xsl:template name="speakingNotes">
		<xsl:for-each select="//note[@type='speaking']">
			<div>
				<h1><xsl:value-of select="parent::div/head"/></h1>
				<xsl:apply-templates/>
			</div>
		</xsl:for-each>
	</xsl:template>
	
	<xsl:template match="note[@type='speaking']"/>
	
	<xsl:template name="banner">
		<table width="100%" cellpadding="0" cellspacing="0" border="0">
			<tr>
				<td width="220">
					<img src="images/CBMLGirl_Top.gif" border="0" alt="CBML: Comic Book Markup Language Logo" width="220" height="76" />
				</td>
				<td width="100%" colspan="2" bgcolor="#2a678a">
					<img src="images/CBMLSiteTitle.gif" alt="Comic Book Markup Language" border="0" width="528" height="42" />
				</td>
			</tr>
			<tr>
				<td width="220">
					<img src="images/CBMLGirl_Bottom.gif" border="0" alt="CBML: Comic Book Markup Language Logo" width="220" height="24" />
				</td>
				<td background="images/rougeNavBarBG.gif" nowrap="nowrap">
				</td>
				<td background="images/rougeNavBarBG.gif" align="right" style="font-family: comic sans ms; font-weight: bold; font-size: small; color: #EAD95F">
					www.cbml.org&#160;&#160;&#160;&#160;
				</td>
			</tr>
		</table>
	</xsl:template>
	<xsl:template name="outputChunk">
		<xsl:param name="ident" />
		<xsl:param name="content" />
		<xsl:variable name="outName">
			<xsl:choose>
				<xsl:when test="not($outputDir ='')">
					<xsl:value-of select="$outputDir" />
					<xsl:if test="not(substring($outputDir,string-length($outputDir),string-length($outputDir))='/')">
						<xsl:text>
							/
						</xsl:text>
					</xsl:if>
					<xsl:value-of select="concat($ident,'.html')" />
				</xsl:when>
				
				<xsl:otherwise>
					<xsl:value-of select="concat($ident,'.html')" />
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:choose>
			<xsl:when test="$ident=''">
				<xsl:copy-of select="$content" />
			</xsl:when>
			<xsl:otherwise>
				<xsl:choose>
					<xsl:when test="$outputAsDiv = true">
						<xsl:result-document href="{$outName}" encoding="utf-8" method="xml" omit-xml-declaration="yes">
							<xsl:copy-of select="$content" />
						</xsl:result-document>
					</xsl:when>
					<xsl:otherwise>
						<xsl:result-document href="{$outName}" encoding="utf-8" method="xml" omit-xml-declaration="no" doctype-public="-//W3C//DTD XHTML 1.1//EN" doctype-system="xhtml11-flat.dtd">
							<xsl:copy-of select="$content" />
						</xsl:result-document>
					</xsl:otherwise>
				</xsl:choose>
				<xsl:if test="$verbose='true'">
					<xsl:message>
						Closing file 
						<xsl:value-of select="$outName" />
					</xsl:message>
				</xsl:if>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
	
</xsl:stylesheet>
