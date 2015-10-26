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

			<!-- ============================================
			This one line of code processes everything in
			the body of the document.  The template that
			processes the <body> element in turn processes
			everything that's inside it.
			=============================================== -->

			<xsl:apply-templates select="/html/body/div/table"/>

		</fo:flow>
	</xsl:template>





	<!-- Template for the table tag -->
	<xsl:template match="table">

		<!-- Handles the caption -->
		<fo:block>
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

		<!-- ============================================
		For a table cell, we put everything inside a
		<fo:table-cell> element.  We set the padding
		property correctly, then we set the border
		style.  For the border style, we look to see if
		any of the ancestor elements we care about
		specified a solid border.  Next, we check for the
		rowspan, colspan, and align attributes.  Notice
		that for align, we check this element, then go
		up the ancestor chain until we find the <table>
		element or we find something that specifies the
		alignment.
		=============================================== -->

		<xsl:template match="td">
			<fo:table-cell
				padding-start="3pt" padding-end="3pt"
				padding-before="3pt" padding-after="3pt">
				<xsl:if test="@colspan">
					<xsl:attribute name="number-columns-spanned">
						<xsl:value-of select="@colspan"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:if test="@rowspan">
					<xsl:attribute name="number-rows-spanned">
						<xsl:value-of select="@rowspan"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:if test="@border='1' or
					ancestor::tr[@border='1'] or
					ancestor::thead[@border='1'] or
					ancestor::table[@border='1']">
					<xsl:attribute name="border-style">
						<xsl:text>solid</xsl:text>
					</xsl:attribute>
					<xsl:attribute name="border-color">
						<xsl:text>black</xsl:text>
					</xsl:attribute>
					<xsl:attribute name="border-width">
						<xsl:text>1pt</xsl:text>
					</xsl:attribute>
				</xsl:if>
				<xsl:variable name="align">
					<xsl:choose>
						<xsl:when test="@align">
							<xsl:choose>
								<xsl:when test="@align='center'">
									<xsl:text>center</xsl:text>
								</xsl:when>
								<xsl:when test="@align='right'">
									<xsl:text>end</xsl:text>
								</xsl:when>
								<xsl:when test="@align='justify'">
									<xsl:text>justify</xsl:text>
								</xsl:when>
								<xsl:otherwise>
									<xsl:text>start</xsl:text>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:when>
						<xsl:when test="ancestor::tr[@align]">
							<xsl:choose>
								<xsl:when test="ancestor::tr/@align='center'">
									<xsl:text>center</xsl:text>
								</xsl:when>
								<xsl:when test="ancestor::tr/@align='right'">
									<xsl:text>end</xsl:text>
								</xsl:when>
								<xsl:when test="ancestor::tr/@align='justify'">
									<xsl:text>justify</xsl:text>
								</xsl:when>
								<xsl:otherwise>
									<xsl:text>start</xsl:text>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:when>
						<xsl:when test="ancestor::thead">
							<xsl:text>center</xsl:text>
						</xsl:when>
						<xsl:when test="ancestor::table[@align]">
							<xsl:choose>
								<xsl:when test="ancestor::table/@align='center'">
									<xsl:text>center</xsl:text>
								</xsl:when>
								<xsl:when test="ancestor::table/@align='right'">
									<xsl:text>end</xsl:text>
								</xsl:when>
								<xsl:when test="ancestor::table/@align='justify'">
									<xsl:text>justify</xsl:text>
								</xsl:when>
								<xsl:otherwise>
									<xsl:text>start</xsl:text>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:when>
						<xsl:otherwise>
							<xsl:text>start</xsl:text>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:variable>
				<fo:block text-align="{$align}">
					<xsl:apply-templates select="*|text()"/>
				</fo:block>
			</fo:table-cell>
		</xsl:template>

		<!-- ============================================
		The rarely-used <tfoot> element contains some
		number of <tr> elements; we just invoke the
		template for <tr> here.
		=============================================== -->

		<xsl:template match="tfoot">
			<xsl:apply-templates select="tr"/>
		</xsl:template>

		<!-- ============================================
		If there's a <th> element, we process it just
		like a normal <td>, except the font-weight is
		always bold and the text-align is always center.
		=============================================== -->

		<xsl:template match="th">
			<fo:table-cell
				padding-start="3pt" padding-end="3pt"
				padding-before="3pt" padding-after="3pt">
				<xsl:if test="@border='1' or
					ancestor::tr[@border='1'] or
					ancestor::table[@border='1']">
					<xsl:attribute name="border-style">
						<xsl:text>solid</xsl:text>
					</xsl:attribute>
					<xsl:attribute name="border-color">
						<xsl:text>black</xsl:text>
					</xsl:attribute>
					<xsl:attribute name="border-width">
						<xsl:text>1pt</xsl:text>
					</xsl:attribute>
				</xsl:if>
				<fo:block font-weight="bold" text-align="center">
					<xsl:apply-templates select="*|text()"/>
				</fo:block>
			</fo:table-cell>
		</xsl:template>

		<!-- ============================================
		Just like <tfoot>, the rarely-used <thead> element
		contains some number of table rows.  We just
		invoke the template for <tr> here.
		=============================================== -->

		<xsl:template match="thead">
			<xsl:apply-templates select="tr"/>
		</xsl:template>

		<!-- ============================================
		The title of the document is rendered in a large
		bold font, centered on the page.  This is the
		<title> element in the <head> in <html>.
		=============================================== -->

		<xsl:template match="title">
			<fo:block space-after="18pt" line-height="27pt"
				font-size="24pt" font-weight="bold" text-align="center">
				<xsl:apply-templates select="*|text()"/>
			</fo:block>
		</xsl:template>

		<!-- ============================================
		For an HTML table row, we create an XSL-FO table
		row, then invoke the templates for everything
		inside it.
		=============================================== -->

		<xsl:template match="tr">
			<fo:table-row>
				<xsl:apply-templates select="*|text()"/>
			</fo:table-row>
		</xsl:template>

		<!-- ============================================
		This template generates an <fo:table-column>
		element for each token in the cols attribute of
		the HTML <table> tag.  The template processes
		the first token, then invokes itself with the
		rest of the string.
		=============================================== -->

		<xsl:template name="build-columns">
			<xsl:param name="cols"/>

			<xsl:if test="string-length(normalize-space($cols))">
				<xsl:variable name="next-col">
					<xsl:value-of select="substring-before($cols, ' ')"/>
				</xsl:variable>
				<xsl:variable name="remaining-cols">
					<xsl:value-of select="substring-after($cols, ' ')"/>
				</xsl:variable>
				<xsl:choose>
					<xsl:when test="contains($next-col, 'pt')">
						<fo:table-column column-width="{$next-col}"/>
					</xsl:when>
					<xsl:when test="number($next-col) &gt; 0">
						<fo:table-column column-width="{concat($next-col, 'pt')}"/>
					</xsl:when>
					<xsl:otherwise>
						<fo:table-column column-width="50pt"/>
					</xsl:otherwise>
				</xsl:choose>

				<xsl:call-template name="build-columns">
					<xsl:with-param name="cols" select="concat($remaining-cols, ' ')"/>
				</xsl:call-template>
			</xsl:if>
		</xsl:template>

	</xsl:stylesheet>
