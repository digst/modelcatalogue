<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
xmlns:owl="http://www.w3.org/2002/07/owl#"
xmlns:dc="http://purl.org/dc/elements/1.1/"
xmlns:dct="http://purl.org/dc/terms/"
xmlns:uml="http://www.omg.org/spec/UML/20110701" 
xmlns:xmi="http://www.omg.org/spec/XMI/20110701" 
xmlns:thecustomprofile="http://www.sparxsystems.com/profiles/thecustomprofile/1.0" 
xmlns:Grunddata="http://www.sparxsystems.com/profiles/Grunddata/1.0" 
xmlns:GML="http://www.sparxsystems.com/profiles/GML/1.0"            
xmlns:vann="http://purl.org/vocab/vann/"
xmlns:dcat="http://www.w3.org/ns/dcat#"
xmlns:adms="http://www.w3.org/ns/adms#"
xmlns:cc="http://www.sparxsystems.com/profiles/GML/1.0"
xmlns:foaf="http://xmlns.com/foaf/0.1/" 
xmlns:skos="http://www.w3.org/2004/02/skos/core#" 
xmlns:dadk="http://data.gov.dk/model/vocabular/modelcat#"  >
  <xsl:output method="html"/>
<!--  //rdf:Description/rdf:type[@rdf:resource='http://www.w3.org/ns/dcat#Dataset' ]/../dcat:theme[@rdf:resource='http://publications.europa.eu/resource/authority/data-theme/ECON']/.. -->   	        	
  
<xsl:param name="spi" select="//rdf:Description"/>   	  
<xsl:param name="stix" select="//rdf:type[@rdf:resource='http://www.w3.org/ns/dcat#Dataset' ]/.."/>   	  
<xsl:param name="nSetParam"/>   	  
<xsl:param name="sub-path"  select="//dcat:theme[@rdf:resource='http://publications.europa.eu/resource/authority/data-theme/ECON']/.."/>
        
 
        
<xsl:template match="rdf:RDF">
   
   

        
	<HTML>
		<HEAD>

			<TITLE>Modelkataloget</TITLE>
			<link rel="stylesheet" type="text/css" href="modelkatalog.css"/>
		</HEAD>
	    <BODY>
	  <xsl:choose>
      
          <xsl:when test="$nSetParam = ''">
				<xsl:call-template name="contents">
				  	<xsl:with-param name="nSet" select = "//rdf:type[@rdf:resource='http://www.w3.org/ns/dcat#Dataset' ]/.." />
				</xsl:call-template>
	      </xsl:when>
          <xsl:otherwise>
    		    <xsl:call-template name="contents">
	     			<xsl:with-param name="nSet" select = "$nSetParam" />
    			</xsl:call-template>
	      </xsl:otherwise>
     </xsl:choose>
     
	</BODY>
    </HTML>
</xsl:template>	    	 

	      	  <xsl:template name="contents">
	      	  <xsl:param name="nSet"></xsl:param>
	      	  	<xsl:for-each select="$nSet">
	    
	    		
		    	  	<div>
			  <xsl:for-each select="dct:title[@xml:lang='da']"> 
			    	  			<h2><xsl:value-of select="."/></h2>
			    	  	</xsl:for-each>


			    	  	<table>

			    	  		<tr><td>Prefix:</td><td> <xsl:value-of select="vann:preferredNamespacePrefix"/></td></tr>
			    	  	 	<tr><td>Namespace:</td><td>  <xsl:value-of select="vann:preferredNamespaceUri"/></td></tr>
			    	  		<xsl:for-each select="dct:description[@xml:lang='da']"> 
			    	  	  		<tr><td>Beskrivelse:</td><td>  <xsl:value-of select="."/></td></tr>
			    	  	 	</xsl:for-each>
<!-- nøgleord -->
			    	  		<xsl:for-each select="dcat:keyword"> 
			    	  			 <xsl:if test=". != ''">
 				    	  	  		<tr><td>Nøgleord:</td><td>  <xsl:value-of select="."/></td></tr>
			    	  	  		</xsl:if>
			    	  	 	</xsl:for-each>
						
							<xsl:if test="dct:issued != ''"> 
			    	  	  		<tr><td>Udgivelsesdato:</td><td>  <xsl:value-of select="dct:issued"/></td></tr>
			    	  	  	</xsl:if>
			    	  	 	
						<xsl:for-each select="dct:modified">
							<xsl:if test=". != ''"> 
			    	  	  		<tr><td>Ændringsdato:</td><td>  <xsl:value-of select="."/></td></tr>
			    	  	  		</xsl:if>
			    	  	 	</xsl:for-each>	
						<xsl:for-each select="owl:versionInfo">
							<xsl:if test=". != ''"> 
			    	  	  		<tr><td>Version:</td><td>  <xsl:value-of select="."/></td></tr>
			    	  	  		</xsl:if>
			    	  	 	</xsl:for-each>			
						<xsl:for-each select="adms:versionNotes">
							<xsl:if test=". != ''"> 
			    	  	  		<tr><td>Versioneringsnoter:</td><td>  <xsl:value-of select="."/></td></tr>
			    	  	  		</xsl:if>
			    	  	 	</xsl:for-each>					
						<xsl:for-each select="dct:publisher">
							<xsl:if test="@rdf:resource != ''"> 
			    	  	  		<tr><td>Udgiver:</td><td>  <xsl:value-of select="@rdf:resource"/></td></tr>
			    	  	  		</xsl:if>
			    	  	 	</xsl:for-each>
						<xsl:for-each select="dct:rights">
							<xsl:if test=". != ''"> 
			    	  	  		<tr><td>Rettigheder:</td><td>  <xsl:value-of select="."/></td></tr>
			    	  	  			</xsl:if>
			    	  	 	</xsl:for-each>			
						<xsl:for-each select="cc:license">
							<xsl:if test="@rdf:resource != ''"> 
			    	  	  		<tr><td>Licens:</td><td>  <xsl:value-of select="@rdf:resource"/></td></tr>
			    	  	  		</xsl:if>
			    	  	 	</xsl:for-each>
<!-- hjemmeside -->
						<xsl:for-each select="dcat:landingPage">
							<xsl:if test="@rdf:resource != ''"> 
							<xsl:variable name="hjSide">
							    <xsl:value-of select="@rdf:resource"/>
							</xsl:variable> 
			    	  	  		<tr><td>Hjemmeside:</td><td><a href="{$hjSide}" target="_blank"> <xsl:value-of select="$hjSide"/></a></td></tr>
			    	  	  		</xsl:if>
			    	  	 	</xsl:for-each>
<!-- infoside -->
						<xsl:for-each select="foaf:page"> 
							<xsl:if test="@rdf:resource != ''"> 
								<xsl:variable name="infSide">
								    <xsl:value-of select="@rdf:resource"/>
								</xsl:variable> 
			    	  	  		<tr><td>Infoside:</td><td><a href="{$infSide}" target="_blank"> <xsl:value-of select="$infSide"/></a></td></tr>
			    	  	 	</xsl:if>
			    	  	 </xsl:for-each>
<!-- dcat:theme -->
						<xsl:for-each select="dcat:theme"> 
							<xsl:if test="@rdf:resource != ''"> 
								<xsl:variable name="mThemeRef">
								    <xsl:value-of select="@rdf:resource"/>
								</xsl:variable> 
								<xsl:variable name="themeFull">
								    <xsl:value-of select="document('data-theme-skos-ap-act.rdf')/rdf:RDF/skos:Concept[@rdf:about=$mThemeRef]/skos:prefLabel[@xml:lang='da']"/>
								</xsl:variable> 
			    	  	  		<tr><td>MDR data tema:</td>
								<td> <span  title="{$themeFull}">  
								<xsl:value-of select="document('data-theme-skos-ap-act.rdf')/rdf:RDF/skos:Concept[@rdf:about=$mThemeRef]/dc:identifier"/> 
								</span></td></tr>
							</xsl:if>
						</xsl:for-each>
<!-- modeltype -->
						<xsl:for-each select="dadk:modelType"> 
							<xsl:if test="@rdf:resource != ''"> 
								<xsl:variable name="mType">
								    <xsl:value-of select="@rdf:resource"/>
								</xsl:variable> 
								<xsl:variable name="mDesc">
								    <xsl:value-of select="document('ModelTypes.rdf.xml')/rdf:RDF/rdf:Description[@rdf:about=$mType]/skos:definition[@xml:lang='da']"/>
								</xsl:variable> 
				    	  	  		<tr><td>Modelregel-modeltype:</td>
									<td> <span  title="{$mDesc}">  
									<xsl:value-of select="document('ModelTypes.rdf.xml')/rdf:RDF/rdf:Description[@rdf:about=$mType]/skos:prefLabel[@xml:lang='da']"/> 
								</span></td></tr>
							</xsl:if>
			    	  	 </xsl:for-each>
<!-- modelleringsniveau -->
						<xsl:for-each select="dadk:modellingLevel"> 
							<xsl:if test="@rdf:resource != ''"> 
			    	  	  		<xsl:variable name="mType">
								    <xsl:value-of select="@rdf:resource"/>
								</xsl:variable> 
								<xsl:variable name="mDesc">
								    <xsl:value-of select="document('ModellingLevels.rdf.xml')/rdf:RDF/rdf:Description[@rdf:about=$mType]/skos:definition[@xml:lang='da']"/>
								</xsl:variable> 
				    	  	  		<tr><td>Modelregel-modelleringsniveau:</td>
									<td> <span  title="{$mDesc}">  
									<xsl:value-of select="document('ModellingLevels.rdf.xml')/rdf:RDF/rdf:Description[@rdf:about=$mType]/skos:prefLabel[@xml:lang='da']"/> 
								</span></td></tr>
							</xsl:if>
			    	  	 </xsl:for-each>
<!-- modelleringsregime -->
						<xsl:for-each select="dadk:modellingRegime">
							<xsl:if test="@rdf:resource != ''">  
								<xsl:variable name="mType">
								    <xsl:value-of select="@rdf:resource"/>
								</xsl:variable> 
								<xsl:variable name="mDesc">
								    <xsl:value-of select="document('ModellingRegimes.rdf.xml')/rdf:RDF/rdf:Description[@rdf:about=$mType]/skos:definition[@xml:lang='da']"/>
								</xsl:variable> 
				    	  	  		<tr><td>Modelleringsregime:</td>
									<td> <span  title="{$mDesc}">  
									<xsl:value-of select="document('ModellingRegimes.rdf.xml')/rdf:RDF/rdf:Description[@rdf:about=$mType]/skos:prefLabel[@xml:lang='da']"/> 
								</span></td></tr>
							</xsl:if>
		    	  	 	</xsl:for-each>
<!-- forretningsområde -->
						<xsl:for-each select="dadk:businessArea">
							<xsl:if test=". != ''">  
								<xsl:variable name="FORMopgave">
								    <xsl:value-of select="."/> 
								</xsl:variable> 
								<tr><td>FORM-forretningsområde:</td><td>  <a href="http://www.form-online.dk/soegning?action=search&amp;tekst={$FORMopgave}" target="_blank"> <xsl:value-of select="$FORMopgave"/></a></td></tr>
							</xsl:if>
			    	  	 </xsl:for-each>
<!-- forretningsområde-kode -->
						<xsl:for-each select="dadk:businessAreaCode">
							<xsl:if test=". != ''">  
								<xsl:variable name="FORMopgaveKode">
								    <xsl:value-of select="."/> 
								</xsl:variable> 
				    	  	  	<tr><td>FORM-kode:</td><td>   <a href="http://www.form-online.dk:8080/FORM-REST/resources/{$FORMopgaveKode}" target="_blank"> <xsl:value-of select="$FORMopgaveKode"/></a></td></tr>
				    	  	  </xsl:if>
			    	  	 </xsl:for-each>
<!-- INSPIRE-tema -->
						<xsl:for-each select="dadk:INSPIRETheme">
							<xsl:if test="@rdf:resource != ''">  
								<xsl:variable name="mTheme">
								    <xsl:value-of select="@rdf:resource"/>
								</xsl:variable> 
								<xsl:variable name="themeDesc">
								    <xsl:value-of select="document('theme.da.rdf')/rdf:RDF/rdf:Description[@rdf:about=$mTheme]/dct:description[@xml:lang='da']"/>
								</xsl:variable> 
				    	  	  		<tr>
									<td>IMSPIRE-tema:</td>
									<td> <span  title="{$themeDesc}">  
									<xsl:value-of select="document('theme.da.rdf')/rdf:RDF/rdf:Description[@rdf:about=$mTheme]/dct:title[@xml:lang='da']"/> 
								</span></td></tr>
							</xsl:if>			    	  	  		
			    	  	 </xsl:for-each>
<!-- EIRA-type -->
						<xsl:for-each select="dct:type">
							<xsl:if test="@rdf:resource != ''">  
								<xsl:variable name="EIRAref">
								    <xsl:value-of select="@rdf:resource"/>
								</xsl:variable> 
								<xsl:variable name="EIRAdef">
								    <xsl:value-of select="document('EIRA_SKOS.rdf')/rdf:RDF/skos:Concept[@rdf:about=$EIRAref]/skos:definition[@xml:lang='en']"/>
								</xsl:variable> 
	
				    	  	  		<tr><td>EIRA objekt-type:</td>
									<td> <span  title="{$EIRAdef}">  
									<xsl:value-of select="document('EIRA_SKOS.rdf')/rdf:RDF/skos:Concept[@rdf:about=$EIRAref]/skos:prefLabel"/> 
									</span></td></tr>
								</xsl:if>
			    	  	 </xsl:for-each>
<!-- udgivelser -->

						<xsl:for-each select="dcat:distribution">
							<xsl:if test="@rdf:resource != ''">  
				    	  	  		<tr><td>Udgivelse:</td><td>  <xsl:value-of select="@rdf:resource"/></td></tr>
				    	  	 </xsl:if>
				    	</xsl:for-each> 
				    	  	 	
			    	  	</table>
		    	  	<!-- 

	<cc:license rdf:resource="http://creativecommons.org/licenses/by/3.0/"/>

-->
		  	     	  	    	  	    	  	 
	    	  	 	</div>
	    
	  
	    	</xsl:for-each>
	    </xsl:template>
	    		  


</xsl:stylesheet>
