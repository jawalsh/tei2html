<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" 
    xmlns:eg="http://www.tei-c.org/ns/Examples"
    xmlns:xdoc="http://www.pnp-software.com/XSLTdoc" exclude-result-prefixes="#all"
    xmlns:fn="http://www.w3.org/2005/xpath-functions"
    xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl">

    
    <xd:doc scope="stylesheet">
        <xd:desc>
        This file is a collection of configurable parameters and variables used throughout the other tei2html modules.</xd:desc>
    </xd:doc>
    
    <!-- If true, interactive notes are enabled in XHTML output. -->
    <xsl:param name="enableMouseoverNotes" as="xs:boolean" select="true()"/>
    
    <!-- Variable for the apostrophe character ('), useful for embedding JavaScript or other code in XSLT. -->
    <xsl:variable name="apos">'</xsl:variable>
    
    <!-- end-of-line (eol) hyphenation: If true, end-of-line recorded in TEI using choice[orig][reg] is reproduced in XHTML output. -->
    <xsl:param name="eol" as="xs:boolean" select="true()"/>
    
    <!-- Path to the directory/folder containing the data being transformed.  This parameter is used with $xtmFile parameter to generate the value for the $xtm parameter, with the $glossaryFile parameter to generate the value for the $glossary parameter. -->
    <xsl:param name="dataRoot" as="xs:string">
        <xsl:value-of select="'/Users/jawalsh/development/swinburne/data/'"/>
    </xsl:param>
    
    <!-- The name of the Topic Map (XTML 2.0) containting topics referenced by the TEI/XML data. -->
    <xsl:param name="xtmFile" as="xs:string">
        <xsl:value-of select="'swinburne.xtm'"/>
    </xsl:param>
    
    <!-- Determines whether the thematic keyword box includes a whole line of context, or just the segment. -->
    <xsl:param name="keyword_context" as="xs:string">
        <xsl:value-of select="'seg'"/>
    </xsl:param>
    
    <!-- If true, triggers additional processing for use of stylesheets within XTF system. --> 
    <xsl:param name="xtf" as="xs:boolean" select="false()"/>
    
    
    <!-- Full path of XTM topic map file, which is used to populate glosses of difficult or unfamiliar topics. -->
    <xsl:variable name="xtm">
        <xsl:copy-of select="document(concat('file://',$dataRoot,$xtmFile))"/>
    </xsl:variable>
    
    <!-- Filename of glossary file, which is used to populate glosses of difficult or unfamiliar words. -->
    <xsl:param name="glossaryFile" as="xs:string">
        <xsl:value-of select="'swinburneGlossary.xml'"/>
    </xsl:param>
    
    <!-- Full path of glossary file, which is used to populate glosses of difficult or unfamiliar topics. -->
    <xsl:variable name="glossary">
        <xsl:copy-of select="document(concat('file://',$dataRoot,$glossaryFile))"/>
    </xsl:variable>
    
    <!-- URL to base tei2html JavaScript file. -->
    <xsl:param name="jsFile" as="xs:string" select="'http://ella.slis.indiana.edu/~jawalsh/share/js/tei2html.js'"/>

    
    <!-- If true, a document metadata section is included at top of document. -->
    <xsl:param name="includeDocumentInformation" as="xs:boolean" select="true()"/>
    
    <!-- If true, a header with title, author, etc. info is output. -->
    <xsl:param name="includeDocHeader" as="xs:boolean" select="true()"/>
    
    
    <!-- String preceding editorial interventions, e.g. the open square bracket in [illeg.], [sic], etc. -->
    <xsl:param name="preEditorialIntervention" as="xs:string">[</xsl:param>
    
    <!-- String following editorial interventions, e.g. the close square bracket in [illeg.], [sic], etc. -->
    <xsl:param name="postEditorialIntervention" as="xs:string">]</xsl:param>
    


    <!-- If true, the document is output as with an XHTML div as root element, for includsion in larger XHTML document. -->
    <xsl:param name="outputAsDiv" as="xs:boolean" select="false()"/>

    <!-- If true choice/abbr is expanded to choice/expan. -->
    <xsl:param name="expandAbbr" as="xs:boolean" select="false()"/>

    <!-- If true choice/orig is regularized to choice/reg. -->
    <xsl:param name="regularizeOrig" as="xs:boolean" select="false()"/>

    <!-- If true choice/sic is corrected to choice/corr. -->
    <xsl:param name="correctSic" as="xs:boolean" select="true()"/>
    
    <!-- URL of primary CSS file -->
    <xsl:param name="cssFile" as="xs:string">file:///Users/jawalsh/development/tei2html/css/tei2html.css</xsl:param>
    
    
    <!-- <xsl:param name="imagePath" as="xs:string" select="''"/>-->
    
    
    <!-- If true, then CSS and js are embedded in the html file -->
    <xsl:param name="standalone" as="xs:boolean" select="true()"/>
    
    <!-- Sets frequency of line numbers for poetry.  If set to "0" no line numbers will be displayed; if set to "1" every line number will be displayed; if set to "5" every fifth line number will be display; and so on. -->
    <xsl:param name="lineNumberFrequency" as="xs:integer">10</xsl:param>
    
    <!-- If true, tables are numbered. -->
    <xsl:param name="numberTables" as="xs:boolean" select="true()"/>
    
    <!-- A label for numbered tables; modify for other languages. -->
    <xsl:param name="tableLabel" as="xs:string">Table</xsl:param>
    
    <!-- Path to xml source.  Assumes a path that will be prepended to a document id to produce a link to the XML source file. -->
    <xsl:param name="xmlSourcePath" as="xs:string" select="'http://www.purl.org/swinburnearchive/source/xml/'"/>
    
    <!-- If true, figures are numbered -->    
    <xsl:param name="numberFigures" as="xs:boolean" select="true()"/>
    
    <!-- Defines symbol to identify presence of mouseover notes. -->
    <xsl:param name="refSymbol" as="xs:string" select="'°'"/>
    
    <!-- If true, linked XHTML presentation slides are produced as output. -->
    <xsl:param name="makingSlides" as="xs:boolean" select="false()"/>
    
    <!-- If true, page breaks represented by <pb> tags are displayed in output. -->
    <xsl:param name="displayPageBreaks" as="xs:boolean" select="true()"/>
    
    <!-- If true, links to facsimile page images are displayed in output. -->
    <xsl:param name="displayPageImageLinks" as="xs:boolean" select="true()"/>
    
    <!-- If true, a list of linked thematic keywords/phrases is produced. Requires that such words/phrases have been tagged in a prescribed manner.  -->
    <xsl:param name="displayThematicKeywords" as="xs:boolean" select="false()"/>
    
    <!-- If true, words/phrases tagged as thematic keywords are highlighted in output. -->
    <xsl:param name="highlight-keywords" as="xs:boolean" select="false()"/>
    
    <!-- If true, a heading will be generated for endnotes -->
    <xsl:param name="supplyEndnoteHead" as="xs:boolean" select="true()"/>
    
    <!-- Name of copyright holders -->
    <xsl:param name="copyrightHolders">John A. Walsh</xsl:param>

    <xd:doc>
        <xd:desc>Template to generate copyright statement.</xd:desc>
    </xd:doc>
    <xsl:template name="copyrightStatement">
        <xsl:text> Copyright &#x00a9; </xsl:text>
        <xsl:value-of select="fn:year-from-dateTime(fn:current-dateTime())"/>
            <xsl:text> </xsl:text>
            <xsl:value-of select="$copyrightHolders"/>
    </xsl:template>
    
<!-- from p4 below, need to clean up -->
    <xsl:param name="tooltipDates" as="xs:boolean" select="false()"/>
    <xsl:param name="headerFrom" as="xs:string" select="'from'"/>
    <xsl:param name="headerTo" as="xs:string" select="'to'"/>
    
    

</xsl:stylesheet>
