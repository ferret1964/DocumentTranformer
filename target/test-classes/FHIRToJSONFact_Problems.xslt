<?xml version="1.0" encoding="UTF-8"?>
<!--
This file was generated by Altova MapForce 2013sp1

YOU SHOULD NOT MODIFY THIS FILE, BECAUSE IT WILL BE
OVERWRITTEN WHEN YOU RE-RUN CODE GENERATION.

Refer to the Altova MapForce Documentation for further details.
http://www.altova.com/mapforce
-->
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:ns0="http://hl7.org/fhir" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:fn="http://www.w3.org/2005/xpath-functions" exclude-result-prefixes="ns0 xs fn">
	<xsl:output method="xml" encoding="UTF-8" indent="yes"/>
	<xsl:param name="status" as="xs:string?" select="()"/>
	<xsl:template match="/">
		<patientDataFact>
			<xsl:attribute name="xsi:noNamespaceSchemaLocation" namespace="http://www.w3.org/2001/XMLSchema-instance" select="'JSONFact_Problem.xsd'"/>
			<factType>Diagnoses</factType>
			<xsl:for-each select="ns0:ProblemList">
				<xsl:variable name="var7_resultof_filter" as="node()*">
					<xsl:for-each select="ns0:Problem">
						<xsl:variable name="var5_resultof_map" as="xs:boolean?">
							<xsl:for-each select="ns0:status">
								<xsl:variable name="var4_resultof_map" as="xs:boolean*">
									<xsl:for-each select="ns0:coding">
										<xsl:variable name="var3_resultof_map" as="xs:boolean?">
											<xsl:for-each select="ns0:display">
												<xsl:variable name="var1_value" as="node()?" select="@value"/>
												<xsl:choose>
													<xsl:when test="fn:exists($var1_value)">
														<xsl:variable name="var2_result" as="xs:string">
															<xsl:choose>
																<xsl:when test="fn:exists($status)">
																	<xsl:sequence select="$status"/>
																</xsl:when>
																<xsl:otherwise>
																	<xsl:sequence select="'ACTIVE;INACTIVE'"/>
																</xsl:otherwise>
															</xsl:choose>
														</xsl:variable>
														<xsl:sequence select="fn:contains($var2_result, fn:string($var1_value))"/>
													</xsl:when>
													<xsl:otherwise>
														<xsl:sequence select="fn:false()"/>
													</xsl:otherwise>
												</xsl:choose>
											</xsl:for-each>
										</xsl:variable>
										<xsl:sequence select="fn:exists($var3_resultof_map[.])"/>
									</xsl:for-each>
								</xsl:variable>
								<xsl:sequence select="fn:exists($var4_resultof_map[.])"/>
							</xsl:for-each>
						</xsl:variable>
						<xsl:variable name="var6_resultof_any" as="xs:boolean" select="fn:exists($var5_resultof_map[.])"/>
						<xsl:if test="$var6_resultof_any">
							<xsl:sequence select="."/>
						</xsl:if>
					</xsl:for-each>
				</xsl:variable>
				<xsl:for-each select="$var7_resultof_filter">
					<xsl:variable name="var8_id" as="node()?" select="@id"/>
					<xsl:variable name="var9_resultof_first" as="node()" select="ns0:code"/>
					<xsl:variable name="var10_coding" as="node()*" select="$var9_resultof_first/ns0:coding"/>
					<facts>
						<lastRecordedDate>
							<xsl:sequence select="xs:string(xs:date('2000-01-01'))"/>
						</lastRecordedDate>
						<xsl:for-each select="($var9_resultof_first/ns0:text)[fn:exists(@value)]">
							<problem>
								<xsl:sequence select="fn:string(@value)"/>
							</problem>
						</xsl:for-each>
						<xsl:for-each select="($var10_coding/ns0:code)[fn:exists(@value)]">
							<code>
								<xsl:sequence select="fn:string(@value)"/>
							</code>
						</xsl:for-each>
						<xsl:for-each select="($var10_coding/ns0:system)[fn:exists(@value)]">
							<codeSystemName>
								<xsl:sequence select="fn:concat(xs:string(xs:anyURI(fn:string(@value))), ' not translated')"/>
							</codeSystemName>
						</xsl:for-each>
						<xsl:for-each select="($var10_coding/ns0:system)[fn:exists(@value)]">
							<codeSystemCode>
								<xsl:sequence select="xs:string(xs:anyURI(fn:string(@value)))"/>
							</codeSystemCode>
						</xsl:for-each>
						<xsl:for-each select="ns0:dateAsserted[fn:exists(@value)]">
							<xsl:variable name="var11_resultof_cast" as="xs:double" select="xs:double(xs:decimal('2'))"/>
							<xsl:variable name="var12_resultof_cast" as="xs:string" select="fn:string(@value)"/>
							<onset>
								<xsl:sequence select="xs:string(xs:date(fn:concat(fn:concat(fn:concat(fn:concat(fn:substring($var12_resultof_cast, xs:double(xs:decimal('1')), xs:double(xs:decimal('4'))), '-'), fn:substring($var12_resultof_cast, xs:double(xs:decimal('5')), $var11_resultof_cast)), '-'), fn:substring($var12_resultof_cast, xs:double(xs:decimal('7')), $var11_resultof_cast))))"/>
							</onset>
						</xsl:for-each>
						<xsl:if test="fn:exists($var8_id)">
							<itemId>
								<xsl:sequence select="fn:string($var8_id)"/>
							</itemId>
						</xsl:if>
						<xsl:for-each select="(ns0:status/ns0:coding/ns0:display)[fn:exists(@value)]">
							<status>
								<xsl:sequence select="fn:string(@value)"/>
							</status>
						</xsl:for-each>
						<xsl:for-each select="ns0:extension">
							<xsl:variable name="var13_cur" as="node()" select="."/>
							<xsl:for-each select="(((ns0:valueCodeableConcept/ns0:coding/ns0:display)[fn:exists(@value)])[fn:exists($var13_cur/ns0:url/@value)])[(xs:string(xs:anyURI(fn:string($var13_cur/ns0:url/@value))) = 'org.socraticgrid.constants.acuity')]">
								<acuity>
									<xsl:sequence select="fn:string(@value)"/>
								</acuity>
							</xsl:for-each>
						</xsl:for-each>
						<xsl:for-each select="(ns0:contained/ns0:Location)[fn:exists(ns0:name/@value)]">
							<facility>
								<xsl:sequence select="fn:string(ns0:name/@value)"/>
							</facility>
						</xsl:for-each>
					</facts>
				</xsl:for-each>
			</xsl:for-each>
		</patientDataFact>
	</xsl:template>
</xsl:stylesheet>
