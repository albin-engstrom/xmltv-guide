<?xml version="1.0" encoding="UTF-8"?>

<!-- Stylesheet and xml namespace -->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<!-- Set output to xml -->
	<xsl:output method="xml" indent="yes"/>

	<!-- Template -->
	<xsl:template match="/">

		<!-- Iterate through Listings -->
		<xsl:for-each select="/Listings/Listing">

			<!-- Variable with root tags for the listing -->
			<xsl:variable name="ListingRoot" select="document(.)/tv" />

			<!-- The tag that hold programmes -->
			<Programmes>

				<!-- Iterate through all programme elements -->
				<xsl:for-each select="$ListingRoot/programme">

					<!-- The element holding the programme metadata -->
					<Programme>

						<!-- The title -->
						<Title>
							<xsl:value-of select="title"/>
						</Title>

						<!-- The channel -->
						<Channel>
							<xsl:value-of select="@channel"/>
						</Channel>

						<!-- The start time -->
						<Start>
							<xsl:value-of select="@start"/>
						</Start>

						<!-- The stop time -->
						<Stop>
							<xsl:value-of select="@stop"/>
						</Stop>

					</Programme>
				</xsl:for-each>
			</Programmes>
		</xsl:for-each>
	</xsl:template>
</xsl:stylesheet>
