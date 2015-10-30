<?xml version="1.0"?>
<xsl:stylesheet
	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:fo="http://www.w3.org/1999/XSL/Format">

	<!-- Set output to xml -->
	<xsl:output method="xml"/>

	<!-- Template for the html tag -->
	<xsl:template match="html">

		<!-- Xsl-fo root -->
		<fo:root xmlns:fo="http://www.w3.org/1999/XSL/Format">

			<!-- Page layout -->
			<fo:layout-master-set>
				<fo:simple-page-master master-name="tv-guide">
					<fo:region-body margin="1in"/>
				</fo:simple-page-master>
			</fo:layout-master-set>


			<!-- Document body -->
			<fo:page-sequence master-reference="tv-guide">
				<xsl:apply-templates select="body"/>
			</fo:page-sequence>
		</fo:root>
	</xsl:template>

	<!-- Template for the body tag -->
	<xsl:template match="body">


		<!-- Apply templates on the document -->
		<fo:flow flow-name="xsl-region-body">

			<!-- On the title -->
			<xsl:apply-templates select="/html/head/title"/>

			<!-- On the table -->
			<xsl:apply-templates select="/html/body/div/table"/>

		</fo:flow>
	</xsl:template>

	<!-- Template for the table tag -->
	<xsl:template match="table">

		<!-- Handles the caption -->
		<fo:block font-size="35pt" font-weight="bold" padding-before="20pt"
			text-align="center">
			<xsl:apply-templates select="caption|text()"/>
		</fo:block>

		<!-- Creates a table using the cols attribute from the xhtml table -->
		<fo:table table-layout="fixed" inline-progression-dimension="100%">
			<xsl:call-template name="build-columns">
				<xsl:with-param name="cols"
					select="concat(@cols, ' ')"/>
			</xsl:call-template>
			<fo:table-body>
				<xsl:apply-templates select="*"/>
			</fo:table-body>
		</fo:table>
	</xsl:template>

		<!-- Template for the td tag -->
		<xsl:template match="td">

			<!-- Create a cell -->
			<fo:table-cell
				padding-start="3pt" padding-end="3pt"
				padding-before="3pt" padding-after="3pt">

				<!-- Set the border -->
				<xsl:attribute name="border-style">
					<xsl:text>solid</xsl:text>
				</xsl:attribute>
				<xsl:attribute name="border-color">
					<xsl:text>black</xsl:text>
				</xsl:attribute>
				<xsl:attribute name="border-width">
					<xsl:text>1pt</xsl:text>
				</xsl:attribute>

				<!-- Adds the text abd lef align it -->
				<fo:block text-align="left">
					<xsl:apply-templates select="*|text()"/>
				</fo:block>

			</fo:table-cell>
		</xsl:template>

		<!-- Template for the th tag -->
		<xsl:template match="th">

			<!-- Create a cell -->
			<fo:table-cell
				padding-start="3pt" padding-end="3pt"
				padding-before="3pt" padding-after="3pt">

					<!-- Set border -->
					<xsl:attribute name="border-style">
						<xsl:text>solid</xsl:text>
					</xsl:attribute>
					<xsl:attribute name="border-color">
						<xsl:text>black</xsl:text>
					</xsl:attribute>
					<xsl:attribute name="border-width">
						<xsl:text>1pt</xsl:text>
					</xsl:attribute>

				<!-- Add the text bold and left aligned -->
				<fo:block font-weight="bold" text-align="left">
					<xsl:apply-templates select="*|text()"/>
				</fo:block>

			</fo:table-cell>
		</xsl:template>

		<!-- Template for the title tag -->
		<xsl:template match="title">
			<fo:block space-after="18pt" line-height="27pt"
				font-size="24pt" font-weight="bold" text-align="center">
				<xsl:apply-templates select="*|text()"/>
			</fo:block>
		</xsl:template>

		<!-- Template for the tr tag -->
		<xsl:template match="tr">
			<fo:table-row>
				<xsl:apply-templates select="*|text()"/>
			</fo:table-row>
		</xsl:template>

		<!-- Creates table columns using the cols attribute of the html table -->
		<xsl:template name="build-columns">
			<xsl:param name="cols"/>

			<!-- If there are anything left in $cols -->
			<xsl:if test="string-length(normalize-space($cols))">

				<!-- Set the remaining cols -->
				<xsl:variable name="remaining-cols">
					<xsl:value-of select="substring-after($cols, ' ')"/>
				</xsl:variable>

				<!-- Call itself with the remaining columns -->
				<xsl:call-template name="build-columns">
					<xsl:with-param name="cols" select="concat($remaining-cols, ' ')"/>
				</xsl:call-template>

			</xsl:if>
		</xsl:template>

	</xsl:stylesheet>
