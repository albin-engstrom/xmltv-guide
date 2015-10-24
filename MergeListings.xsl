<?xml version="1.0" encoding="UTF-8"?>

<!-- Filename: MergeListings.xml -->
<!-- Author: Albin Engström -->

<!-- Stylesheet and xml namespace -->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<!-- Set output to xml -->
	<xsl:output method="xml" encoding="UTF-8" indent="yes"/>

	<!-- Template -->
	<xsl:template match="/">

		<!-- Element to hold listing data and links an xml schema -->
		<Listings
				xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
		 			xsi:SchemaLocation="AllListings.xsd">

			<!-- Holds the channel data -->
			<Channels>

				<!-- Iterate through Listings -->
				<xsl:for-each select="/Listings/Listing">

					<!-- Holds the channel info -->
					<Channel>

						<!-- The channel name -->
						<Name><xsl:value-of select="./Channel"/></Name>

						<!-- The channel logo -->
						<Logo><xsl:value-of select="./Logo"/></Logo>

					</Channel>
				</xsl:for-each>
			</Channels>

			<!-- The tag that hold programmes -->
			<Programmes>

				<!-- Iterate through Listings -->
				<xsl:for-each select="/Listings/Listing">

					<xsl:variable name="File" select="./File"/>

					<!-- Variable with root element for the listing file -->
					<xsl:variable name="Root" select="document($File)/tv"/>

					<!-- Iterate through all programme elements -->
					<xsl:for-each select="$Root/programme">

						<!-- The element holding the programme metadata -->
						<Programme>

							<!-- The title -->
							<Title><xsl:value-of select="title"/></Title>

							<!-- The channel -->
							<Channel><xsl:value-of select="@channel"/></Channel>

							<!-- The start time -->
							<Start><xsl:value-of select="@start"/></Start>

							<!-- The stop time -->
							<Stop><xsl:value-of select="@stop"/></Stop>

						</Programme>
					</xsl:for-each>
				</xsl:for-each>
			</Programmes>
		</Listings>
	</xsl:template>
</xsl:stylesheet>
