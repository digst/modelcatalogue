<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
xmlns:owl="http://www.w3.org/2002/07/owl#"
xmlns:dc="http://purl.org/dc/elements/1.1/"
xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
xmlns:dct="http://purl.org/dc/terms/"
xmlns:uml="http://www.omg.org/spec/UML/20110701" 
xmlns:xmi="http://www.omg.org/spec/XMI/20110701" 
xmlns:thecustomprofile="http://www.sparxsystems.com/profiles/thecustomprofile/1.0" 
xmlns:Grunddata="http://www.sparxsystems.com/profiles/Grunddata/1.0" 
xmlns:GML="http://www.sparxsystems.com/profiles/GML/1.0"            
xmlns:vann="http://purl.org/vocab/vann/"
xmlns:dcat="http://www.w3.org/ns/dcat#"
xmlns:adms="http://www.w3.org/ns/adms#"
xmlns:voag="http://voag.linkedmodel.org/voag#" 
xmlns:cc="http://www.sparxsystems.com/profiles/GML/1.0"
xmlns:foaf="http://xmlns.com/foaf/0.1/"  
xmlns:vs="http://www.w3.org/2003/06/sw-vocab-status/ns#"
xmlns:plus="https://data.gov.dk/model/core/plus#" 
xmlns:skos="http://www.w3.org/2004/02/skos/core#" 
xmlns:dadk="http://data.gov.dk/model/vocabular/modelcat#"  >
<xsl:output method="html"/>

<!--
==================================================================================================================================================================================
XSL STYLESHEET FOR TRANFORMING RDF/XML TO HTML
==================================================================================================================================================================================
-->
 
<xsl:param name="spi" select="//rdf:Description"/>   	  
<xsl:param name="stix" select="//rdf:type[@rdf:resource='http://www.w3.org/ns/dcat#Dataset' ]/.."/>   	  
<xsl:param name="stiParam"/>   	  
<xsl:param name="sub-path"  select="//dcat:theme[@rdf:resource='http://publications.europa.eu/resource/authority/data-theme/ECON']/.."/>
        
 
<xsl:template match="rdf:RDF">
	<HTML>
		<HEAD>

			<TITLE>HTML-visning</TITLE>
			<link rel="stylesheet" type="text/css" href="htmltransform.css"/>
		</HEAD>
	    <BODY>
<i>Denne side er under udvikling (This page is under development)</i>
<!-- Show model type and status in box-->
<div class="status">
	<div><span>
	   <xsl:choose>
		 <xsl:when test="//rdf:type[@rdf:resource='https://data.gov.dk/model/core/plus#ApplicationProfile' ]/..">	
		Application Profile </xsl:when>	
		 <xsl:when test="//rdf:type[@rdf:resource='https://data.gov.dk/model/core/plus#Vocabulary' ]/..">	
		Vocabulary </xsl:when>
		 <xsl:when test="//rdf:type[@rdf:resource='https://data.gov.dk/model/core/plus#ConceptModel' ]/..">	
		Concept Model </xsl:when>	
		 <xsl:when test="//rdf:type[@rdf:resource='http://www.w3.org/2004/02/skos/core#ConceptScheme' ]/..">	
		Classification	</xsl:when>	<xsl:otherwise>							 
		Model </xsl:otherwise>		
	   </xsl:choose>
		- <xsl:value-of select="rdf:Description/adms:status"/>		   
	</span></div>
</div>

<!-- Show model meta data of application profiles-->
<xsl:for-each select="//rdf:type[@rdf:resource='https://data.gov.dk/model/core/plus#ApplicationProfile' ]/..|
					  //rdf:type[@rdf:resource='https://data.gov.dk/model/core/plus#Vocabulary' ]/..|
					  //rdf:type[@rdf:resource='https://data.gov.dk/model/core/plus#ConceptModel' ]/..|
					  //rdf:type[@rdf:resource='http://www.w3.org/2004/02/skos/core#ConceptScheme' ]/..">

<h1><xsl:value-of select="rdfs:label[@xml:lang='da']"/>&#160;
	(<xsl:value-of select="rdfs:label[@xml:lang='en']"/>)
</h1>

Download serialisering: <a href="plusprofile.rdf.xml">RDF/XML</a>&#160; <a href="plusprofile.rdf.ttl">TTL</a>&#160; <a href="plusprofile.xmi">XMI</a> 
<hr/>

		<h2>METADATA:</h2>

		
<xsl:for-each select="rdfs:comment[@xml:lang='da']"><p><xsl:value-of select="."/></p></xsl:for-each> 

<div class="table">
		<dl>
		<dt>Namespace:</dt><dd><xsl:value-of select="@rdf:about"/></dd>	
		<xsl:if test="vann:preferredNamespacePrefix">
		<dt>Namespaceprefix:</dt><dd><xsl:value-of select="vann:preferredNamespacePrefix"/></dd>
		</xsl:if>
		<dt>Modelnavn:</dt><dd>
			 <xsl:for-each select="rdfs:label[@xml:lang='da']"> <xsl:value-of select="."/>&#160;</xsl:for-each> 
             <xsl:for-each select="rdfs:label[@xml:lang='en']"><i>(<xsl:value-of select="."/>)</i></xsl:for-each></dd>			 
		<dt>Modelejer:</dt><dd><xsl:for-each select="dct:publisher"> <xsl:value-of select="."/></xsl:for-each></dd> 
		<dt>Versionsnummer:</dt><dd><xsl:value-of select="owl:versionInfo"/></dd>
		<dt>Seneste opdateringsdato:</dt><dd><xsl:value-of select="dct:modified"/></dd>
		<dt>Modelstatus:</dt><dd><xsl:value-of select="adms:status"/></dd>
		<dt>Godkendelsesstatus:</dt><dd><xsl:value-of select="plus:approvalStatus"/></dd>
		<dt>Forretningsområde:</dt><dd><xsl:for-each select="dct:theme"> <xsl:value-of select="."/></xsl:for-each></dd> 	 
		<xsl:if test="plus:legalSource"><dt>Juridisk kilde:</dt><dd><xsl:for-each select="plus:legalSource"> <xsl:value-of select="."/>; </xsl:for-each></dd></xsl:if>
		<xsl:if test="dct:source"><dt>Kilde:</dt><dd><xsl:for-each select="dct:source"> <xsl:value-of select="."/>; </xsl:for-each></dd></xsl:if>		
		</dl>
</div>

<!--Show UML Diagram  -->
		<xsl:if test="voag:hasOntologyArchitectureDiagram">
		<h2>DIAGRAM:</h2>	
		<img><xsl:attribute name="src"><xsl:value-of select="voag:hasOntologyArchitectureDiagram"/></xsl:attribute></img>		
		</xsl:if>

</xsl:for-each>

 
<!--Show Table with Namespaces  
		<h2>NAMESPACES:</h2>
		<dl class="table">
			<dt></dt><dd></dd>
		</dl>
		<p>Table with namespaces applied in this profile</p>
-->
		
<!--Show Classes  -->	
		<xsl:if test="rdfs:Class|owl:Class">
		<h2>KLASSER:</h2>
		<xsl:for-each select="rdfs:Class|owl:Class">
		    	  	<div class="resource">
					<h3>
					   <xsl:for-each select="skos:prefLabel[@xml:lang='da']"> <xsl:value-of select="."/>&#160;</xsl:for-each> 
					   <i>(<xsl:value-of select="skos:prefLabel[@xml:lang='en']"/><xsl:for-each select="rdfs:label"><xsl:value-of select="."/></xsl:for-each>)</i></h3>
					<dl>
					  <xsl:call-template name="ressourceinfo"> </xsl:call-template> 			  
					  <xsl:call-template name="classinfo"> </xsl:call-template>  
					  <xsl:call-template name="applicationnotes"> </xsl:call-template>  
					</dl>
	    	  	 	</div>		
	   </xsl:for-each>
	   </xsl:if>
	   
<!--Show Properties  -->
<!--Show Properties that have been specified as rdf:Property/owl:AnnotationProperty/owl:ObjectProperty/owl:DatatypeProperty-->	
		<xsl:if test="rdf:Property|owl:AnnotationProperty|owl:ObjectProperty|owl:DatatypeProperty|rdf:Description/rdf:type[@rdf:resource='http://www.w3.org/2002/07/owl#ObjectProperty']">
		<h2>EGENSKABER:</h2>
		<xsl:for-each select="rdf:Property|owl:AnnotationProperty|owl:ObjectProperty|owl:DatatypeProperty">
		    	  	<div class="resource"><h3>
					   <xsl:for-each select="skos:prefLabel[@xml:lang='da']"> <xsl:value-of select="."/>&#160;</xsl:for-each> 
					   <i>(<xsl:value-of select="skos:prefLabel[@xml:lang='en']"/><xsl:for-each select="rdfs:label"><xsl:value-of select="."/></xsl:for-each>)</i></h3>
					<dl>			
					  <xsl:call-template name="ressourceinfo"> </xsl:call-template>  
					  <xsl:call-template name="propertyinfo"> </xsl:call-template> 
					  <xsl:call-template name="applicationnotes"> </xsl:call-template> 					  
					  </dl>
	    	  	 	</div>
	   </xsl:for-each>	

<!--Show Properties that have been specified as rdf:Description -->	
		<xsl:for-each select="rdf:Description/rdf:type[@rdf:resource='http://www.w3.org/2002/07/owl#ObjectProperty']">
		    	  	<div class="resource"><h3>
					   <xsl:for-each select="../skos:prefLabel[@xml:lang='da']"><xsl:value-of select="."/>&#160;</xsl:for-each> 
					   <xsl:for-each select="../rdfs:label"><i>(<xsl:value-of select="."/>)</i></xsl:for-each></h3>
					<dl>						
					  <xsl:call-template name="ressourceinfo"> </xsl:call-template>  
					  <xsl:call-template name="propertyinfo"> </xsl:call-template> 
					  <xsl:call-template name="applicationnotes"> </xsl:call-template> 	
					  </dl>
	    	  	 	</div>
	   </xsl:for-each>	
	   </xsl:if>
	   
<!--Show SKOS CONCEPT INSTANCES  -->
		<xsl:if test="rdf:Description/rdf:type[@rdf:resource='http://www.w3.org/2004/02/skos/core#Concept']">	
		<h2>KLASSIFIKATIONSELEMENTER:</h2>
		<xsl:for-each select="rdf:Description">
		<xsl:if test="rdf:type[@rdf:resource='http://www.w3.org/2004/02/skos/core#Concept']"> 
		    	  	<div class="resource"><h3>
					   <xsl:for-each select="skos:prefLabel[@xml:lang='da']"> <xsl:value-of select="."/>&#160;</xsl:for-each> 
					   <i>(<xsl:value-of select="skos:prefLabel[@xml:lang='en']"/><xsl:for-each select="rdfs:label"><xsl:value-of select="."/></xsl:for-each>)</i></h3>
					<dl>
					  <xsl:call-template name="ressourceinfo"> </xsl:call-template> 			  
					  <xsl:call-template name="classinfo"> </xsl:call-template>  
					  <xsl:call-template name="applicationnotes"> </xsl:call-template>  
					<!-- Show the concept scheme -->					  
						<xsl:for-each select="skos:inScheme">
			    	  	  		<dt>Indgår i system:</dt><dd><xsl:value-of select="@rdf:resource"/></dd>
						</xsl:for-each>
			    	  	 						  
					  
					</dl>
	    	  	 	</div>	
		</xsl:if>				
	   </xsl:for-each>	
	   </xsl:if>

<!--Show SKOS CONCEPT SCHEMES  
		<xsl:if test="rdf:Description/rdf:type[@rdf:resource='http://www.w3.org/2004/02/skos/core#ConceptScheme']">	
		<h2>KLASSIFIKATIONSSYSTEM:</h2>
		<xsl:for-each select="rdf:Description">
		<xsl:if test="rdf:type[@rdf:resource='http://www.w3.org/2004/02/skos/core#ConceptScheme']"> 
		    	  	<div class="resource"><h3>
					   <xsl:for-each select="skos:prefLabel[@xml:lang='da']"> <xsl:value-of select="."/>&#160;</xsl:for-each> 
					   <i>(<xsl:value-of select="skos:prefLabel[@xml:lang='en']"/><xsl:for-each select="rdfs:label"><xsl:value-of select="."/></xsl:for-each>)</i></h3>
					<dl>
					  <xsl:call-template name="ressourceinfo"> </xsl:call-template> 			  
					  <xsl:call-template name="classinfo"> </xsl:call-template>  
					  <xsl:call-template name="applicationnotes"> </xsl:call-template>  
		  
					</dl>
	    	  	 	</div>	
		</xsl:if>				
	   </xsl:for-each>	
	   </xsl:if>-->
	   
	   </BODY>
    </HTML>
</xsl:template>	    	 
	    		  
<xsl:template name="ressourceinfo">
			<!--Show alternative labels  -->							
							<xsl:if test="skos:altLabel[@xml:lang='da']!=''">
							<dt>Accepterede termer (da):</dt><dd><xsl:for-each select="skos:altLabel[@xml:lang='da']"><xsl:value-of select="."/>;</xsl:for-each></dd>
							</xsl:if>
							
			<!--Show definition 		
							<xsl:if test="skos:definition[@xml:lang='da']!=''">
							<dt>Definition (da):</dt><dd><xsl:for-each select="skos:definition[@xml:lang='da']"><xsl:value-of select="."/>;</xsl:for-each></dd>
							</xsl:if> -->	

			 <xsl:apply-templates select="skos:definition"/>							
							
			<!--Show example  -->	
							<xsl:if test="skos:example[@xml:lang='da']!=''">
							<dt>Eksempel (da):</dt><dd><xsl:for-each select="skos:example[@xml:lang='da']"><xsl:value-of select="."/>;</xsl:for-each></dd>
							</xsl:if>	
							
			<!--Show comment  	
							<xsl:if test="rdfs:comment[@xml:lang='da']!=''">
							<dt>Kommentar (da):</dt><dd><xsl:for-each select="rdfs:comment[@xml:lang='da']"><xsl:value-of select="."/>;</xsl:for-each></dd>
							</xsl:if>	
-->


			<!--Show comments  -->
			  <xsl:apply-templates select="rdfs:comment"/>

	
			<!--Show legal source	
							<xsl:for-each select="plus:legalSource"><xsl:if test=". != ''"> 
			    	  	  		<dt>Kilde:</dt><dd>  <xsl:value-of select="."/></dd></xsl:if>
			    	  	 	</xsl:for-each>		 
			-->		
			<!--Show source  -->								
							<xsl:for-each select="dct:source"><xsl:if test=". != ''"> 
			    	  	  	<dt>Kilde:</dt><dd>  <xsl:value-of select="."/></dd></xsl:if>
			    	  	 	</xsl:for-each>			    	 

							<xsl:call-template name="identification"> </xsl:call-template> 
</xsl:template>	



<xsl:template match="rdfs:comment">
			<!--Show comment  -->					
						   <xsl:choose>
							 <xsl:when test="@xml:lang">	
			<!--Show comment marked as Danish  -->							 
								<xsl:if test="@xml:lang='da'">
									<dt>Kommentar (da):</dt><dd><xsl:value-of select="."/></dd>	
								</xsl:if>	
			<!--Show comment marked as English  -->									
								<xsl:if test="@xml:lang='en'">
									<dt>Kommentar (en):</dt><dd><xsl:value-of select="."/></dd>	
								</xsl:if>								
							 </xsl:when>						   
							 <xsl:otherwise>
			<!--If the comment is not marked with a language code show comment as English  -->								 
									<dt>Kommentar (en):</dt><dd><xsl:value-of select="."/></dd>								 
							</xsl:otherwise>							 
						   </xsl:choose>
</xsl:template>

<xsl:template match="skos:definition">
			<!--Show comment  -->					
						   <xsl:choose>
							 <xsl:when test="@xml:lang">	
			<!--Show comment marked as Danish  -->							 
								<xsl:if test="@xml:lang='da'">
									<dt>Definition (da):</dt><dd><xsl:value-of select="."/></dd>	
								</xsl:if>	
			<!--Show comment marked as English  -->									
								<xsl:if test="@xml:lang='en'">
									<dt>Definition (en):</dt><dd><xsl:value-of select="."/></dd>	
								</xsl:if>								
							 </xsl:when>						   
							 <xsl:otherwise>
			<!--If the comment is not marked with a language code show comment as English  -->								 
									<dt>Definition (en):</dt><dd><xsl:value-of select="."/></dd>								 
							</xsl:otherwise>							 
						   </xsl:choose>
</xsl:template>


<xsl:template name="identification">
			<!--Show URI   -->	
							<xsl:for-each select="@rdf:about"><xsl:if test=". != ''"> 
			    	  	  	<dt>URI:</dt><dd>  <xsl:value-of select="."/></dd></xsl:if>
			    	  	 	</xsl:for-each>	

			<!--Show URI of vocabulary that defines the resource  -->	
							<dt>Er defineret af:</dt><dd><xsl:value-of select="rdfs:isDefinedBy/@rdf:resource"/></dd>	
</xsl:template>	


<xsl:template name="classinfo">
			<!--Show the class which the current class is a specialisation of   -->	
							<xsl:for-each select="rdfs:subClassOf/@rdf:resource"><xsl:if test=". != ''"> 
			    	  	  	<dt>Specialisering af:</dt><dd>  <xsl:value-of select="."/></dd></xsl:if>
			    	  	 	</xsl:for-each>				
			<!--Show the class which is equivalent to the current class   -->		
							<xsl:for-each select="owl:equivalentClass/@rdf:resource"><xsl:if test=". != ''"> 
			    	  	  	<dt>Ækvivalent klasse:</dt><dd>  <xsl:value-of select="."/></dd></xsl:if>
			    	  	 	</xsl:for-each>					    	  			
</xsl:template>	


<xsl:template name="propertyinfo">
			<!--Show the property which the current property is a specialisation of   -->	
							<xsl:for-each select="rdfs:subPropertyOf/@rdf:resource"><xsl:if test=". != ''"> 
			    	  	  	<dt>Specialisering af:</dt><dd>  <xsl:value-of select="."/></dd></xsl:if>
							</xsl:for-each>	    
			<!--Show the domain(s) of the property -->	
							<xsl:for-each select="rdfs:domain/@rdf:resource"><xsl:if test=". != ''"> 
			    	  	  	<dt>Domæne:</dt><dd>  <xsl:value-of select="."/></dd></xsl:if>
							</xsl:for-each>	
			<!--Show the range(s) of the property -->	
							<xsl:for-each select="rdfs:range/@rdf:resource"><xsl:if test=". != ''"> 
			    	  	  	<dt>Rækkevidde:</dt><dd>  <xsl:value-of select="."/></dd></xsl:if>
							</xsl:for-each>	
			<!--Show the property which is equivalent to the current property   -->	
							<xsl:for-each select="owl:equivalentProperty/@rdf:resource"><xsl:if test=". != ''"> 
			    	  	  	<dt>Ækvivalent egenskab:</dt><dd>  <xsl:value-of select="."/></dd></xsl:if>
			    	  	 	</xsl:for-each>								 
</xsl:template>	


<xsl:template name="applicationnotes">
			<!--Show usage note  -->	
							<xsl:if test="vann:usageNote[@xml:lang='en']!=''"><dt></dt><dd></dd>
			    	  		<xsl:for-each select="vann:usageNote[@xml:lang='en']"> 
							<dt class="usage"><div class="usage">Anvendelsesnote:</div></dt><dd class="usage"><div class="usage"><xsl:value-of select="."/></div></dd></xsl:for-each>
							</xsl:if>									 
				
</xsl:template>	


</xsl:stylesheet>
