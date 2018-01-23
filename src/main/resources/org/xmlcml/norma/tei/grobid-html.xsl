<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:mml="http://www.w3.org/1998/Math/MathML"
    xmlns:xlink="http://www.w3.org/1999/xlink"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xlink xs mml tei"
    version="1.0">
	<xsl:output method="html"/>

	<xsl:template match="/">
		<html>
			<xsl:apply-templates/>
		</html>
	</xsl:template>

	
	<xsl:template match="*">
			<h4><xsl:value-of select="name()"/></h4>
			<xsl:message><xsl:value-of select="name()"/></xsl:message>
			<xsl:apply-templates/>
	</xsl:template>

	<!-- ===============TEI TAGS================== -->
    <xsl:template match="tei:abstract">
		<h3>Abstract</h3>
		<xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="tei:address">
		<h2>Address <xsl:apply-templates/></h2>
		<xsl:call-template name="missingChildren">
			<xsl:with-param name="restList" select="*[not(self::tei:foo | self::tei:foo)]"/>
			<xsl:with-param name="parent" select="local-name()"></xsl:with-param>
		</xsl:call-template>
    </xsl:template>

    <xsl:template match="tei:addrLine">
		<h2>AddrLine <xsl:apply-templates/></h2>
		<xsl:call-template name="missingChildren">
			<xsl:with-param name="restList" select="*[not(self::tei:foo | self::tei:foo)]"/>
			<xsl:with-param name="parent" select="local-name()"></xsl:with-param>
		</xsl:call-template>
    </xsl:template>

    <xsl:template match="tei:analytic">
		<h2>Analytic</h2>
		<xsl:apply-templates select="tei:title"/>
		<xsl:apply-templates select="tei:author"/>
		<xsl:call-template name="missingChildren">
			<xsl:with-param name="restList" select="*[not(self::tei:title | self::tei:author)]"/>
			<xsl:with-param name="parent" select="local-name()"></xsl:with-param>
		</xsl:call-template>
    </xsl:template>

	<xsl:template match="tei:appInfo">
		<h4>appInfo</h4>
		<xsl:apply-templates select="tei:application"/>
		<xsl:call-template name="missingChildren">
			<xsl:with-param name="restList" select="*[not(self::tei:application)]"/>
			<xsl:with-param name="parent" select="local-name()"></xsl:with-param>
		</xsl:call-template>
	</xsl:template>

	<xsl:template match="tei:application">
		<h4>application</h4>
		<xsl:apply-templates select="tei:ref"/>
		<xsl:call-template name="missingChildren">
			<xsl:with-param name="restList" select="*[not(self::tei:ref)]"/>
			<xsl:with-param name="parent" select="local-name()"></xsl:with-param>
		</xsl:call-template>
	</xsl:template>

    <xsl:template match="tei:author">
		<span><b>Author </b><xsl:value-of select="."/></span>
		<xsl:apply-templates select="tei:persName"/>
		<xsl:call-template name="missingChildren">
			<xsl:with-param name="restList" select="*[not(self::tei:persName)]"/>
			<xsl:with-param name="parent" select="local-name()"></xsl:with-param>
		</xsl:call-template>
    </xsl:template>

    <xsl:template match="tei:availability">
      <h3><i>availability: </i><xsl:value-of select="."/></h3>
    </xsl:template>
	
	<xsl:template match="tei:back">
		<xsl:apply-templates select="tei:div"/>
	</xsl:template>  

	<xsl:template match="tei:biblScope">
		<h4><xsl:value-of select="@unit"/>[]<xsl:value-of select="@from"/>:<xsl:value-of select="@to"/>]</h4>
		<xsl:call-template name="missingChildren">
			<xsl:with-param name="restList" select="*[not(self::tei:foo)]"/>
			<xsl:with-param name="parent" select="local-name()"></xsl:with-param>
		</xsl:call-template>
	</xsl:template>  


    <xsl:template match="tei:biblStruct">
		<h2>Bibliodata</h2>
		<xsl:apply-templates select="tei:analytic"/>
		<xsl:apply-templates select="tei:monogr"/>
    </xsl:template>

	<xsl:template match="tei:body">
		<xsl:apply-templates select="tei:div"/>
		<xsl:apply-templates select="tei:figure"/>
	</xsl:template>  
	
    <xsl:template match="tei:date">
      <h4><i>date: </i><xsl:value-of select="@type"/>=<xsl:value-of select="@when"/></h4>
    </xsl:template>

	<xsl:template match="tei:div">
		<div>
			<xsl:apply-templates/>
		</div>
	</xsl:template>  

	<xsl:template match="tei:encodingDesc">
		<h4>encoding</h4>
		<!--
			<appInfo>
				<application version="0.5.1-SNAPSHOT" ident="GROBID" when="2018-01-21T13:42+0000">
					<ref target="https://github.com/kermitt2/grobid">GROBID - A machine learning software for extracting information from scholarly documents</ref>
				</application>
			</appInfo>
			-->
		<xsl:apply-templates select="tei:appInfo"/>
		<xsl:call-template name="missingChildren">
			<xsl:with-param name="restList" select="*[not(self::tei:appInfo)]"/>
			<xsl:with-param name="parent" select="local-name()"></xsl:with-param>
		</xsl:call-template>
	</xsl:template>
	
	<xsl:template match="tei:figure">
		<h2>
			<xsl:if test="@type='table'">TABLE</xsl:if>
			<xsl:if test="not(@type='table')">FIGURE</xsl:if>
		</h2>
		
		<xsl:apply-templates select="tei:head"/>
		<xsl:apply-templates select="tei:label"/>
		<xsl:apply-templates select="tei:figDesc"/>
		<xsl:apply-templates select="tei:graphic"/>
		<xsl:apply-templates select="tei:table"/>
		<xsl:call-template name="missingChildren">
			<xsl:with-param name="restList" select="*[not(self::tei:head | self::tei:label | self::tei:figDesc | self::tei:graphic | self::tei:table)]"/>
			<xsl:with-param name="parent" select="local-name()"></xsl:with-param>
		</xsl:call-template>
	</xsl:template>  

	<xsl:template match="tei:figDesc">
		<h2>Fig: <xsl:apply-templates/></h2>[
		<xsl:call-template name="missingChildren">
			<xsl:with-param name="restList" select="*[not(self::tei:foo | self::tei:foo)]"/>
			<xsl:with-param name="parent" select="local-name()"></xsl:with-param>
		</xsl:call-template>
		]
	</xsl:template>  

	<xsl:template match="tei:fileDesc">
		<h3>FILE</h3>
		<xsl:apply-templates select="tei:titleStmt"/>
		<xsl:apply-templates select="tei:publicationStmt"/>
		<xsl:apply-templates select="tei:sourceDesc"/>
		<xsl:call-template name="missingChildren">
			<xsl:with-param name="restList" select="*[not(self::tei:titleStmt | self::tei:sourceDesc | self::tei:publicationStmt)]"/>
			<xsl:with-param name="parent" select="local-name()"></xsl:with-param>
		</xsl:call-template>
	</xsl:template>
	
	<xsl:template match="tei:formula">
		<h2>Formula: <xsl:apply-templates/></h2>[
		<xsl:call-template name="missingChildren">
			<xsl:with-param name="restList" select="*[not(self::tei:foo | self::tei:foo)]"/>
			<xsl:with-param name="parent" select="local-name()"></xsl:with-param>
		</xsl:call-template>
		]
	</xsl:template>  

	<xsl:template match="tei:graphic">
		<h2>Graphic: <xsl:apply-templates/></h2>[
		<xsl:call-template name="missingChildren">
			<xsl:with-param name="restList" select="*[not(self::tei:foo | self::tei:foo)]"/>
			<xsl:with-param name="parent" select="local-name()"></xsl:with-param>
		</xsl:call-template>
		]
	</xsl:template>  

	<xsl:template match="tei:head">
		<span class="head">[<xsl:apply-templates/>]</span>
	</xsl:template>  

	<xsl:template match="tei:idno">
		<span class="idno">[<xsl:apply-templates/>]</span>
	</xsl:template>  

	<xsl:template match="tei:imprint">
		<h4>Imprint</h4>
		<xsl:apply-templates select="tei:biblScope"/>
		<xsl:apply-templates select="tei:publisher"/>
		<xsl:apply-templates select="tei:date"/>
		<xsl:apply-templates select="tei:pubPlace"/>
		<xsl:call-template name="missingChildren">
			<xsl:with-param name="restList" select="*[not(self::tei:publisher | self::tei:biblScope
				 | self::tei:date  | self::tei:pubPlace)]"/>
			<xsl:with-param name="parent" select="local-name()"></xsl:with-param>
		</xsl:call-template>
	</xsl:template>  

    <xsl:template match="tei:keywords">
		<h3>keywords</h3>
		<p>
			<xsl:for-each select="tei:term">
			<xsl:value-of select="."/><xsl:text> | </xsl:text>
		    </xsl:for-each>
		</p>
    </xsl:template>
	
	<xsl:template match="tei:label">
		<span class="label">[<xsl:apply-templates/>]</span>
	</xsl:template>  

	<xsl:template match="tei:listBibl">
		<xsl:apply-templates select="tei:biblStruct"/>
	</xsl:template>  
	
	<xsl:template match="tei:meeting">
		<xsl:apply-templates select="tei:biblStruct"/>
	</xsl:template>  
	
	<xsl:template match="tei:monogr">
		<h4>Monogr</h4>[
		<xsl:apply-templates select="tei:author"/>
		<xsl:apply-templates select="tei:idno"/>
		<xsl:apply-templates select="tei:title"/>
		<xsl:apply-templates select="tei:imprint"/>
		<xsl:apply-templates select="tei:meeting"/>
		<xsl:apply-templates select="tei:respStmt"/>
		<xsl:apply-templates select="tei:publPlace"/>
		<xsl:call-template name="missingChildren">
			<xsl:with-param name="restList" select="*[not(self::tei:title | self::tei:imprint
				 | self::tei:biblScope | self::tei:author | self::tei:meeting | self::tei:idno
				  | self::tei:respStmt)]"/>
			<xsl:with-param name="parent" select="local-name()"></xsl:with-param>
		</xsl:call-template>
		]
	</xsl:template>  

    <xsl:template match="tei:orgName">
		<h4>Org name <xsl:apply-templates/></h4>
		<xsl:call-template name="missingChildren">
			<xsl:with-param name="restList" select="*[not(
				self::tei:foo | self::tei:foo)]"/>
			<xsl:with-param name="parent" select="local-name()"></xsl:with-param>
		</xsl:call-template>
    </xsl:template>
  

	<xsl:template match="tei:P | tei:p">
		<p>
			<xsl:apply-templates/>
		</p>
	</xsl:template>  
	
    <xsl:template match="tei:persName">
		<xsl:value-of select="tei:forename"/><xsl:text> : </xsl:text>
		<xsl:value-of select="tei:surname"/>
		<xsl:if test="tei:roleName">
			<xsl:text> Role: </xsl:text><xsl:value-of select="tei:roleName"/>
		</xsl:if>
		<xsl:call-template name="missingChildren">
			<xsl:with-param name="restList" select="*[not(
				self::tei:forename | self::tei:surname | self::tei:roleName)]"/>
			<xsl:with-param name="parent" select="local-name()"></xsl:with-param>
		</xsl:call-template>
    </xsl:template>
  
    <xsl:template match="tei:pubPlace">
		<h4>Pub place <xsl:apply-templates/></h4>
		<xsl:call-template name="missingChildren">
			<xsl:with-param name="restList" select="*[not(
				self::tei:foo | self::tei:foo)]"/>
			<xsl:with-param name="parent" select="local-name()"></xsl:with-param>
		</xsl:call-template>
    </xsl:template>
  
    <xsl:template match="tei:respStmt">
		<h3>Responsibility</h3>
		<xsl:variable name="child" select="tei:resp | tei:orgName | tei:persName"/> -->
		<xsl:apply-templates select="$child"/>
		<xsl:call-template name="missingChildren">
			<xsl:with-param name="restList" select="*[not($child)]"/>
			<xsl:with-param name="parent" select="local-name()"></xsl:with-param>
		</xsl:call-template>
    </xsl:template>
  
    <xsl:template match="tei:profileDesc">
		<h2>ProfileDesc</h2>
		<xsl:variable name="child" select="tei:textClass | tei:abstract"/> -->
		<xsl:apply-templates select="$child"/>
		<xsl:call-template name="missingChildren">
			<xsl:with-param name="restList" select="*[not($child)]"/>
			<xsl:with-param name="parent" select="local-name()"></xsl:with-param>
		</xsl:call-template>
    </xsl:template>

	<xsl:template match="tei:publicationStmt">
		<h2>PublStme</h2>
		<xsl:apply-templates select="tei:publisher"/>
		<xsl:apply-templates select="tei:availability"/>
		<xsl:apply-templates select="tei:date"/>
	</xsl:template>
	
    <xsl:template match="tei:publisher">
      <h3><i>publisher: </i><xsl:value-of select="."/></h3>
    </xsl:template>

    <xsl:template match="tei:ref">
      <a href="{@target}"><xsl:value-of select="."/></a>
    </xsl:template>

    <xsl:template match="tei:sourceDesc">
		<h2>SourceDesc</h2>
		<xsl:apply-templates select="tei:biblStruct"/>
    </xsl:template>

	<xsl:template match="tei:table">
		<xsl:apply-templates/>
	</xsl:template>
	
	<xsl:template match="tei:TEI">
		<html>
			<xsl:apply-templates/>
		</html>
	</xsl:template>
	
	<xsl:template match="tei:teiHeader">
		<div>
			<h2>Header</h2>
			<xsl:apply-templates select="tei:encodingDesc"/>
			<xsl:apply-templates select="tei:fileDesc"/>
			<xsl:apply-templates select="tei:profileDesc"/>
	  </div>
	</xsl:template>
	
	<xsl:template match="tei:text">
		<xsl:apply-templates select="tei:body"/>
		<xsl:apply-templates select="tei:back"/>
	</xsl:template>  

    <xsl:template match="tei:textClass">
		<xsl:apply-templates select="tei:keywords"/>
    </xsl:template>

    <xsl:template match="tei:title">
<!--		<xsl:variable name="atts" select="@level | @type"/>-->
		<xsl:variable name="atts" select="@level | @type"/>
		<h3 class="title">
		<xsl:for-each select="$atts">
			<xsl:attribute name="{local-name()}"><xsl:value-of select="."/></xsl:attribute>
		</xsl:for-each>
		<xsl:value-of select="."/>
		</h3>
<!--		<xsl:variable name="missingAtts" select="$atts[not(local-name()='level') and not(local-name()='type')]"/> -->
		<xsl:variable name="missingAtts" select="$atts[not(local-name()='level')]"/>
		<xsl:message>Missing atts: <xsl:value-of select="count($missingAtts)"/></xsl:message>
	
		<xsl:call-template name="showMissingAtts">
			<xsl:with-param name="atts" select="$missingAtts"/>
			<xsl:with-param name="parent" select="local-name()"></xsl:with-param>
		</xsl:call-template>
		
		<xsl:for-each select="@*">
			<xsl:message>FOO<xsl:value-of select="name()"/></xsl:message>
		</xsl:for-each>
		
    </xsl:template>

	<xsl:template match="tei:titleStmt">
		<h1 class="title"><xsl:value-of select="tei:title"/></h1>
	</xsl:template>

<!-- ============CALLABLE TEMPLATES============= -->	
	
	<xsl:template name="showMissingAtts">
		<xsl:param name="missingAtts"/>
		<xsl:param name="parent"/>
		<xsl:if test="count($missingAtts) != 0">
			<xsl:for-each select="$missingAtts">
				<xsl:message>NO att <xsl:value-of select="$parent"/>:
<!--				<xsl:value-of select="name()"/> -->
			</xsl:message>
			</xsl:for-each>
		</xsl:if>
	</xsl:template>

	<xsl:template name="missingChildren">
		<xsl:param name="restList"/>
		<xsl:param name="parent"/>
		<xsl:if test="count($restList) != 0">
			<xsl:for-each select="$restList">
				<xsl:message>NO child <xsl:value-of select="$parent"/>:<xsl:value-of select="local-name()"/></xsl:message>
			</xsl:for-each>
		</xsl:if>
		<!-- https://stackoverflow.com/questions/585261/is-there-an-xslt-name-of-element -->
	</xsl:template>


</xsl:stylesheet>