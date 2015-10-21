<?xml version="1.0" encoding="UTF-8"?>

<!-- Stylesheet and xml namespace -->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<!-- Set output to xml -->
	<xsl:output method="xml" indent="yes"/>

	<!-- Template -->
	<xsl:template match="/">

		<!-- Variables with the file names -->
		<xsl:variable name="Listing1" select="/Listings/Listing[@nr = '1']" />
		<xsl:variable name="Listing2" select="/Listings/Listing[@nr = '2']" />
		<xsl:variable name="Listing3" select="/Listings/Listing[@nr = '3']" />

		<!-- Variables with root tags for the listings -->
		<xsl:variable name="Listing1Root" select="document($Listing1)/tv" />
		<xsl:variable name="Listing2Root" select="document($Listing2)/tv" />
		<xsl:variable name="Listing3Root" select="document($Listing3)/tv" />

		<Programmes>
			<xsl:for-each select="$Listing1Root/programme">
				<Programme>
					<Title>
						<xsl:value-of select="title"/>
					</Title>
				</Programme>
			</xsl:for-each>
		</Programmes>

	</xsl:template>


</xsl:stylesheet>
