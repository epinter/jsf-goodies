<?xml version="1.0" encoding="UTF-8"?>
<!-- Mark A. Ziesemer, http://www.ziesemer.com + 2008-03-25 -->
<!-- Dawid Pytel, changed to support facelet-taglib (*.taglib.xml) files + 2014-10-14 -->
<xsl:transform version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema"
               xmlns:tlib="$tlibNamespace" exclude-result-prefixes="tlib">
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>
	<xsl:template match="/tlib:facelet-taglib">
		<xsl:comment> Generated by TaglibToXSD XSLT modified by Dawid Pytel https://github.com/destin/jsf-goodies</xsl:comment>
        <xsl:comment> Original XSLT created by + Mark A. Ziesemer, http://www.ziesemer.com + 2008-03-25 </xsl:comment>
	
		<xs:schema version="1.0" xml:lang="en" elementFormDefault="qualified">
			<xsl:attribute name="targetNamespace"><xsl:value-of select="normalize-space(tlib:namespace)"/></xsl:attribute>
			<xs:annotation>
				<xs:documentation><xsl:value-of select="normalize-space(tlib:description)"/></xs:documentation>
				<xs:documentation>tlib-version: <xsl:value-of select="normalize-space(@version)"/></xs:documentation>
			</xs:annotation>
			<xsl:apply-templates select="tlib:tag"/>
		</xs:schema>
	</xsl:template>
	
	<xsl:template match="tlib:tag">
		<xs:element>
			<xsl:attribute name="name"><xsl:value-of select="normalize-space(tlib:tag-name)"/></xsl:attribute>
			<xs:annotation>
                <xsl:if test="tlib:description">
                    <xs:documentation>
                        <xsl:text disable-output-escaping="yes">&lt;![CDATA[</xsl:text>
                        <xsl:value-of select="tlib:description" disable-output-escaping="yes"/>
                        <xsl:text disable-output-escaping="yes">]]&gt;</xsl:text>
                    </xs:documentation>
                </xsl:if>
                <xsl:if test="tlib:component/tlib:component-type">
				    <xs:documentation>component-type: <xsl:value-of select="normalize-space(tlib:component/tlib:component-type)"/></xs:documentation>
                </xsl:if>
                <xsl:if test="tlib:component/tlib:renderer-type">
				    <xs:documentation>renderer-type: <xsl:value-of select="normalize-space(tlib:component/tlib:renderer-type)"/></xs:documentation>
                </xsl:if>
			</xs:annotation>
			<xs:complexType>
				<xsl:if test="not(tlib:body-content='empty')">
					<xsl:attribute name="mixed">true</xsl:attribute>
					<xs:choice minOccurs="0" maxOccurs="unbounded">
						<xs:any processContents="lax"/>
					</xs:choice>
				</xsl:if>
				<xsl:apply-templates select="tlib:attribute"/>
			</xs:complexType>
		</xs:element>
	</xsl:template>
	
	<xsl:template match="tlib:attribute">
		<xs:attribute>
			<xsl:attribute name="name"><xsl:value-of select="normalize-space(tlib:name)"/></xsl:attribute>
			<xsl:if test="normalize-space(tlib:required)='true'">
				<xsl:attribute name="use">required</xsl:attribute>
			</xsl:if>
			<xs:annotation>
				<xs:documentation>
					<xsl:text disable-output-escaping="yes">&lt;![CDATA[</xsl:text>
					<xsl:value-of select="tlib:description" disable-output-escaping="yes"/>
					<xsl:text disable-output-escaping="yes">]]&gt;</xsl:text>
				</xs:documentation>
			</xs:annotation>
		</xs:attribute>
	</xsl:template>
</xsl:transform>
