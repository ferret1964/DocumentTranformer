<?xml version="1.0" encoding="UTF-8"?>
<!--
This file was generated by Altova MapForce 2013sp1

YOU SHOULD NOT MODIFY THIS FILE, BECAUSE IT WILL BE
OVERWRITTEN WHEN YOU RE-RUN CODE GENERATION.

Refer to the Altova MapForce Documentation for further details.
http://www.altova.com/mapforce
-->
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:ns0="http://mdws.medora.va.gov/EmrSvc" xmlns:user="http://www.altova.com/MapForce/UDF/user" xmlns:vmf="http://www.altova.com/MapForce/UDF/vmf" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:fn="http://www.w3.org/2005/xpath-functions" exclude-result-prefixes="ns0 user vmf xs fn">
	<xsl:template name="user:FMDateToHL7">
		<xsl:param name="FMdate" select="()"/>
		<xsl:variable name="var1_resultof_cast" as="xs:double" select="xs:double(xs:decimal('4'))"/>
		<xsl:sequence select="fn:concat(fn:concat(xs:string((xs:double(fn:substring($FMdate, xs:double(xs:decimal('1')), xs:double(xs:decimal('3')))) + xs:double('1700'))), fn:substring($FMdate, $var1_resultof_cast, $var1_resultof_cast)), fn:substring($FMdate, xs:double(xs:decimal('9')), xs:double(xs:decimal('6'))))"/>
	</xsl:template>
	<xsl:template name="vmf:vmf1_inputtoresult">
		<xsl:param name="input" select="()"/>
		<xsl:choose>
			<xsl:when test="$input='ACTIVE'">
				<xsl:value-of select="'active'"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="'completed'"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:output method="xml" encoding="UTF-8" indent="yes"/>
	<xsl:param name="status" as="xs:string?" select="()"/>
	<xsl:template match="/">
		<PrescriptionList xmlns="http://hl7.org/fhir" xmlns:xhtml="http://www.w3.org/1999/xhtml">
			<xsl:attribute name="xsi:schemaLocation" namespace="http://www.w3.org/2001/XMLSchema-instance" select="'http://hl7.org/fhir C:/Users/JERRYG~1/Dropbox/Cognitive/CDS/fhir-all-xsd/cm_prescriptions.xsd'"/>
			<xsl:for-each select="ns0:TaggedTextArray">
				<xsl:variable name="var5_resultof_filter" as="node()*">
					<xsl:for-each select="ns0:results/ns0:TaggedText/ns0:text/ns0:results/ns0:meds/ns0:med">
						<xsl:variable name="var3_resultof_map" as="xs:boolean?">
							<xsl:for-each select="ns0:vaStatus">
								<xsl:variable name="var1_result" as="xs:string">
									<xsl:choose>
										<xsl:when test="fn:exists($status)">
											<xsl:sequence select="$status"/>
										</xsl:when>
										<xsl:otherwise>
											<xsl:sequence select="'active;completed'"/>
										</xsl:otherwise>
									</xsl:choose>
								</xsl:variable>
								<xsl:variable name="var2_resultof_vmf__inputtoresult" as="xs:string">
									<xsl:call-template name="vmf:vmf1_inputtoresult">
										<xsl:with-param name="input" select="fn:string(@value)" as="xs:string"/>
									</xsl:call-template>
								</xsl:variable>
								<xsl:sequence select="fn:contains($var1_result, $var2_resultof_vmf__inputtoresult)"/>
							</xsl:for-each>
						</xsl:variable>
						<xsl:variable name="var4_resultof_any" as="xs:boolean" select="fn:exists($var3_resultof_map[.])"/>
						<xsl:if test="$var4_resultof_any">
							<xsl:sequence select="."/>
						</xsl:if>
					</xsl:for-each>
				</xsl:variable>
				<xsl:for-each select="$var5_resultof_filter">
					<xsl:variable name="var30_cur" as="node()" select="."/>
					<xsl:variable name="var6_doses" as="node()?" select="ns0:doses"/>
					<xsl:variable name="var7_stop" as="node()?" select="ns0:stop"/>
					<xsl:variable name="var8_resultof_cast" as="xs:string" select="xs:string(xs:anyURI('org.socraticgrid.constants.VAStatus'))"/>
					<xsl:variable name="var9_products" as="node()?" select="ns0:products"/>
					<xsl:variable name="var10_orderingProvider" as="node()?" select="ns0:orderingProvider"/>
					<xsl:variable name="var11_facility" as="node()?" select="ns0:facility"/>
					<xsl:variable name="var12_vaStatus" as="node()?" select="ns0:vaStatus"/>
					<xsl:variable name="var13_resultof_cast" as="xs:string" select="xs:string(xs:anyURI('vuid'))"/>
					<Prescription>
						<xsl:for-each select="ns0:id">
							<xsl:attribute name="id" namespace="" select="xs:string(xs:integer(fn:string(@value)))"/>
						</xsl:for-each>
						<contained>
							<Location>
								<name>
									<xsl:for-each select="$var11_facility">
										<xsl:attribute name="id" namespace="" select="xs:string(xs:integer(fn:string(@code)))"/>
									</xsl:for-each>
									<xsl:for-each select="$var11_facility">
										<xsl:variable name="var14_resultof_cast" as="xs:string" select="fn:string(@name)"/>
										<xsl:attribute name="value" namespace="" select="$var14_resultof_cast"/>
									</xsl:for-each>
								</name>
							</Location>
						</contained>
						<identifier>
							<system>
								<xsl:attribute name="value" namespace="" select="xs:string(xs:anyURI('OrderId'))"/>
							</system>
							<id>
								<xsl:for-each select="ns0:orderID">
									<xsl:attribute name="value" namespace="" select="xs:string(xs:integer(fn:string(@value)))"/>
								</xsl:for-each>
							</id>
						</identifier>
						<status>
							<xsl:for-each select="$var12_vaStatus">
								<xsl:attribute name="value" namespace="">
									<xsl:call-template name="vmf:vmf1_inputtoresult">
										<xsl:with-param name="input" select="fn:string(@value)" as="xs:string"/>
									</xsl:call-template>
								</xsl:attribute>
							</xsl:for-each>
							<extension>
								<url>
									<xsl:attribute name="value" namespace="" select="xs:string(xs:anyURI('org.socraticgrid.constant.RecordStatus'))"/>
								</url>
								<valueString>
									<xsl:for-each select="ns0:status">
										<xsl:variable name="var15_resultof_cast" as="xs:string" select="fn:string(@value)"/>
										<xsl:attribute name="value" namespace="" select="$var15_resultof_cast"/>
									</xsl:for-each>
								</valueString>
							</extension>
							<extension>
								<url>
									<xsl:attribute name="value" namespace="" select="$var8_resultof_cast"/>
								</url>
								<valueCoding>
									<system>
										<xsl:attribute name="value" namespace="" select="$var8_resultof_cast"/>
									</system>
									<code>
										<xsl:for-each select="$var12_vaStatus">
											<xsl:attribute name="value" namespace="" select="fn:string(@value)"/>
										</xsl:for-each>
									</code>
								</valueCoding>
							</extension>
						</status>
						<patient>
							<xsl:attribute name="id" namespace="" select="xs:string(xs:decimal('0'))"/>
							<display>
								<xsl:attribute name="value" namespace="" select="'undefined'"/>
							</display>
						</patient>
						<prescriber>
							<display>
								<xsl:for-each select="$var10_orderingProvider">
									<xsl:attribute name="id" namespace="" select="xs:string(xs:integer(fn:string(@code)))"/>
								</xsl:for-each>
								<xsl:for-each select="$var10_orderingProvider">
									<xsl:variable name="var16_resultof_cast" as="xs:string" select="fn:string(@name)"/>
									<xsl:attribute name="value" namespace="" select="$var16_resultof_cast"/>
								</xsl:for-each>
							</display>
						</prescriber>
						<prescribed>
							<xsl:for-each select="ns0:ordered">
								<xsl:variable name="var17_resultof_FMDateToHL_" as="xs:string?">
									<xsl:call-template name="user:FMDateToHL7">
										<xsl:with-param name="FMdate" select="xs:string(xs:decimal(fn:string(@value)))" as="xs:string"/>
									</xsl:call-template>
								</xsl:variable>
								<xsl:if test="fn:exists($var17_resultof_FMDateToHL_)">
									<xsl:attribute name="value" namespace="" select="fn:substring($var17_resultof_FMDateToHL_, xs:double(xs:decimal('1')), xs:double(xs:decimal('8')))"/>
								</xsl:if>
							</xsl:for-each>
						</prescribed>
						<dispense>
							<repeats>
								<xsl:for-each select="ns0:fillsAllowed">
									<xsl:attribute name="value" namespace="" select="xs:string(xs:integer(fn:string(@value)))"/>
								</xsl:for-each>
							</repeats>
							<quantity>
								<value>
									<xsl:for-each select="ns0:quantity">
										<xsl:attribute name="value" namespace="" select="xs:string(xs:integer(fn:string(@value)))"/>
									</xsl:for-each>
								</value>
								<units>
									<xsl:for-each select="ns0:form">
										<xsl:variable name="var18_resultof_cast" as="xs:string" select="fn:string(@value)"/>
										<xsl:attribute name="value" namespace="" select="$var18_resultof_cast"/>
									</xsl:for-each>
								</units>
							</quantity>
						</dispense>
						<medicine>
							<xsl:for-each select="$var9_products">
								<xsl:variable name="var19_resultof_first" as="node()" select="ns0:product/ns0:class"/>
								<extension>
									<url>
										<xsl:attribute name="value" namespace="" select="xs:string(xs:anyURI('org.socraticgrid.constants.drugclass'))"/>
									</url>
									<valueCodeableConcept>
										<coding>
											<system>
												<xsl:attribute name="value" namespace="" select="xs:string(xs:anyURI('drugclass'))"/>
											</system>
											<code>
												<xsl:attribute name="value" namespace="" select="fn:string($var19_resultof_first/@code)"/>
											</code>
										</coding>
										<text>
											<xsl:attribute name="value" namespace="" select="fn:string($var19_resultof_first/@name)"/>
										</text>
									</valueCodeableConcept>
								</extension>
							</xsl:for-each>
							<identification>
								<coding>
									<system>
										<xsl:attribute name="value" namespace="" select="$var13_resultof_cast"/>
									</system>
									<code>
										<xsl:for-each select="$var9_products">
											<xsl:attribute name="value" namespace="" select="xs:string(xs:integer(fn:string(ns0:product/ns0:vaProduct/@vuid)))"/>
										</xsl:for-each>
									</code>
								</coding>
								<text>
									<xsl:for-each select="$var9_products">
										<xsl:attribute name="value" namespace="" select="fn:string(ns0:product/ns0:vaProduct/@name)"/>
									</xsl:for-each>
								</text>
							</identification>
							<activeIngredient>
								<identification>
									<coding>
										<system>
											<xsl:attribute name="value" namespace="" select="$var13_resultof_cast"/>
										</system>
										<code>
											<xsl:for-each select="$var9_products">
												<xsl:attribute name="value" namespace="" select="xs:string(xs:integer(fn:string(ns0:product/ns0:vaGeneric/@vuid)))"/>
											</xsl:for-each>
										</code>
									</coding>
									<text>
										<xsl:for-each select="$var9_products">
											<xsl:attribute name="value" namespace="" select="fn:string(ns0:product/ns0:vaGeneric/@name)"/>
										</xsl:for-each>
									</text>
								</identification>
							</activeIngredient>
						</medicine>
						<administrationRequest>
							<description>
								<xsl:for-each select="ns0:sig">
									<xsl:attribute name="value" namespace="" select="fn:string(.)"/>
								</xsl:for-each>
							</description>
							<start>
								<xsl:for-each select="ns0:start">
									<xsl:variable name="var20_resultof_cast" as="xs:string" select="xs:string(xs:integer(fn:string(@value)))"/>
									<xsl:variable name="var21_resultof_FMDateToHL_" as="xs:string?">
										<xsl:call-template name="user:FMDateToHL7">
											<xsl:with-param name="FMdate" select="$var20_resultof_cast" as="xs:string"/>
										</xsl:call-template>
									</xsl:variable>
									<xsl:if test="fn:exists($var21_resultof_FMDateToHL_)">
										<xsl:attribute name="value" namespace="" select="$var21_resultof_FMDateToHL_"/>
									</xsl:if>
								</xsl:for-each>
							</start>
							<end>
								<xsl:for-each select="$var7_stop">
									<xsl:variable name="var22_resultof_cast" as="xs:string" select="xs:string(xs:integer(fn:string(@value)))"/>
									<xsl:variable name="var23_resultof_FMDateToHL_" as="xs:string?">
										<xsl:call-template name="user:FMDateToHL7">
											<xsl:with-param name="FMdate" select="$var22_resultof_cast" as="xs:string"/>
										</xsl:call-template>
									</xsl:variable>
									<xsl:if test="fn:exists($var23_resultof_FMDateToHL_)">
										<xsl:attribute name="value" namespace="" select="$var23_resultof_FMDateToHL_"/>
									</xsl:if>
								</xsl:for-each>
							</end>
							<dosageInstruction>
								<route>
									<text>
										<xsl:for-each select="$var6_doses">
											<xsl:attribute name="value" namespace="" select="fn:string(ns0:dose/@route)"/>
										</xsl:for-each>
									</text>
								</route>
								<doseQuantity>
									<value>
										<xsl:for-each select="$var6_doses">
											<xsl:attribute name="value" namespace="" select="xs:string(xs:integer(fn:string(ns0:dose/@dose)))"/>
										</xsl:for-each>
									</value>
									<units>
										<xsl:for-each select="$var6_doses">
											<xsl:attribute name="value" namespace="" select="fn:string(ns0:dose/@units)"/>
										</xsl:for-each>
									</units>
								</doseQuantity>
								<schedule>
									<extension>
										<url>
											<xsl:attribute name="value" namespace="" select="xs:string(xs:anyURI('org.socraticgrid.constants.VASchedule'))"/>
										</url>
										<valueString>
											<xsl:for-each select="$var6_doses">
												<xsl:attribute name="value" namespace="" select="fn:string(ns0:dose/@schedule)"/>
											</xsl:for-each>
										</valueString>
									</extension>
									<repeat>
										<duration>
											<xsl:for-each select="$var7_stop">
												<xsl:variable name="var25_resultof_FMDateToHL_" as="xs:string?">
													<xsl:call-template name="user:FMDateToHL7">
														<xsl:with-param name="FMdate" select="xs:string(xs:integer(fn:string(@value)))" as="xs:string"/>
													</xsl:call-template>
												</xsl:variable>
												<xsl:if test="fn:exists($var25_resultof_FMDateToHL_)">
													<xsl:for-each select="$var30_cur/ns0:start">
														<xsl:variable name="var24_resultof_FMDateToHL_" as="xs:string?">
															<xsl:call-template name="user:FMDateToHL7">
																<xsl:with-param name="FMdate" select="xs:string(xs:integer(fn:string(@value)))" as="xs:string"/>
															</xsl:call-template>
														</xsl:variable>
														<xsl:if test="fn:exists($var24_resultof_FMDateToHL_)">
															<xsl:attribute name="value" namespace="" select="xs:string(fn:days-from-duration((xs:date(fn:concat(fn:concat(fn:concat(fn:concat(fn:substring($var25_resultof_FMDateToHL_, xs:double(xs:decimal('1')), xs:double(xs:decimal('4'))), '-'), fn:substring($var25_resultof_FMDateToHL_, xs:double(xs:decimal('5')), xs:double(xs:decimal('2')))), '-'), fn:substring($var25_resultof_FMDateToHL_, xs:double(xs:decimal('7')), xs:double(xs:decimal('2'))))) - xs:date(fn:concat(fn:concat(fn:concat(fn:concat(fn:substring($var24_resultof_FMDateToHL_, xs:double(xs:decimal('1')), xs:double(xs:decimal('4'))), '-'), fn:substring($var24_resultof_FMDateToHL_, xs:double(xs:decimal('5')), xs:double(xs:decimal('2')))), '-'), fn:substring($var24_resultof_FMDateToHL_, xs:double(xs:decimal('7')), xs:double(xs:decimal('2'))))))))"/>
														</xsl:if>
													</xsl:for-each>
												</xsl:if>
											</xsl:for-each>
										</duration>
										<xsl:variable name="var29_resultof_map" as="xs:boolean?">
											<xsl:for-each select="$var7_stop">
												<xsl:variable name="var27_resultof_FMDateToHL_" as="xs:string?">
													<xsl:call-template name="user:FMDateToHL7">
														<xsl:with-param name="FMdate" select="xs:string(xs:integer(fn:string(@value)))" as="xs:string"/>
													</xsl:call-template>
												</xsl:variable>
												<xsl:variable name="var28_result" as="xs:boolean?">
													<xsl:if test="fn:exists($var27_resultof_FMDateToHL_)">
														<xsl:for-each select="$var30_cur/ns0:start">
															<xsl:variable name="var26_resultof_FMDateToHL_" as="xs:string?">
																<xsl:call-template name="user:FMDateToHL7">
																	<xsl:with-param name="FMdate" select="xs:string(xs:integer(fn:string(@value)))" as="xs:string"/>
																</xsl:call-template>
															</xsl:variable>
															<xsl:if test="fn:exists($var26_resultof_FMDateToHL_)">
																<xsl:if test="(fn:days-from-duration((xs:date(fn:concat(fn:concat(fn:concat(fn:concat(fn:substring($var27_resultof_FMDateToHL_, xs:double(xs:decimal('1')), xs:double(xs:decimal('4'))), '-'), fn:substring($var27_resultof_FMDateToHL_, xs:double(xs:decimal('5')), xs:double(xs:decimal('2')))), '-'), fn:substring($var27_resultof_FMDateToHL_, xs:double(xs:decimal('7')), xs:double(xs:decimal('2'))))) - xs:date(fn:concat(fn:concat(fn:concat(fn:concat(fn:substring($var26_resultof_FMDateToHL_, xs:double(xs:decimal('1')), xs:double(xs:decimal('4'))), '-'), fn:substring($var26_resultof_FMDateToHL_, xs:double(xs:decimal('5')), xs:double(xs:decimal('2')))), '-'), fn:substring($var26_resultof_FMDateToHL_, xs:double(xs:decimal('7')), xs:double(xs:decimal('2'))))))) &gt; xs:decimal('0'))">
																	<xsl:sequence select="fn:true()"/>
																</xsl:if>
															</xsl:if>
														</xsl:for-each>
													</xsl:if>
												</xsl:variable>
												<xsl:sequence select="fn:exists($var28_result)"/>
											</xsl:for-each>
										</xsl:variable>
										<units>
											<xsl:if test="fn:exists($var29_resultof_map[.])">
												<xsl:attribute name="value" namespace="" select="'days'"/>
											</xsl:if>
										</units>
									</repeat>
								</schedule>
							</dosageInstruction>
						</administrationRequest>
					</Prescription>
				</xsl:for-each>
			</xsl:for-each>
		</PrescriptionList>
	</xsl:template>
</xsl:stylesheet>
