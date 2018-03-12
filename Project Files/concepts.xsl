<?xml version="1.0" encoding="utf-8"?>
											<xsl:stylesheet version="1.0"
											  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
											  xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
											  xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
											  xmlns:owl="http://www.w3.org/2002/07/owl#"
											  xmlns:dc="http://purl.org/dc/elements/1.1/"
											  xmlns:uml="http://www.omg.org/spec/UML/20110701" 
											  xmlns:xmi="http://www.omg.org/spec/XMI/20110701" 
											  xmlns:thecustomprofile="http://www.sparxsystems.com/profiles/thecustomprofile/1.0" 
											  xmlns:Grunddata="http://www.sparxsystems.com/profiles/Grunddata/1.0" 
											  xmlns:GML="http://www.sparxsystems.com/profiles/GML/1.0"
													>
   

	
   <xsl:output method="html"/>
   	        	
   	<xsl:param name="eaid"/>
   	
    <xsl:template match="/"> 
    	
    	<h2>Begreb:</h2>
   	  	   <xsl:for-each select="//*[@xmi:id=$eaid]">
<!-- <xsl:param name="rangeId" select="type/@xmi:idref"/> -->
    	
	    <h1><xsl:value-of select="@name"/></h1>
	    <h3><xsl:value-of select="@xmi:type"/></h3>
	    
 <h4>Model: <xsl:value-of select="ancestor::*[@xmi:type='uml:Package']/@name"/></h4> 
	    
<xsl:if test="@xmi:type='uml:Class'">	     
	      	 <xsl:apply-templates select="//*[@base_Class=$eaid]"/> 
	     </xsl:if>
<xsl:if test="@xmi:type='uml:Property'">
			 <h4>Domain: <xsl:value-of select="ancestor::*[@xmi:type='uml:Class' or @xmi:type='uml:Association']/@name"/>(<xsl:value-of select="ancestor::*[@xmi:type='uml:Association' or @xmi:type='uml:Class']/@xmi:type"/>)</h4> 
		
	     	<xsl:apply-templates select="type"/>  
	       	 <xsl:apply-templates select="//*[@base_Property=$eaid]"/>	 
	      </xsl:if>  	
	</xsl:for-each>	 	
     </xsl:template>
	   	<xsl:template match="//*[@base_Class=$eaid]">
        		<table border="1">
       		<xsl:for-each select="@*">
       			<xsl:if test="name(.)='definition' or name(.)='alternativtNavn' or name(.)='note' or name(.)='lovgrundlag' or name(.)='note'  or name(.)='eksempel'" >
       			<tr><td><xsl:value-of select="name(.)"/></td><td>    <xsl:value-of select="."/> </td></tr>
       			</xsl:if> 	
       			</xsl:for-each>	 
       			</table>
        	</xsl:template>
    
       	<xsl:template match="//*[@base_Property=$eaid]">
       		<table border="1">
       		<xsl:for-each select="@*">
       			<xsl:if test="name(.)='definition' or name(.)='alternativtNavn' or name(.)='note' or name(.)='lovgrundlag' or name(.)='note'  or name(.)='eksempel'" >
       			<tr><td><xsl:value-of select="name(.)"/></td><td>    <xsl:value-of select="."/> </td></tr>
       			</xsl:if> 	
       			</xsl:for-each>	 
       			</table>
        		
        	</xsl:template>
        	
        	<xsl:template match="//*[@xmi:id=$rangeId]">
        		<h4>Range:<xsl:value-of select="@name"/>  <xsl:value-of select="@xmi:type"/><xsl:value-of select="@UMLType"/></h4>
        	</xsl:template> 
        	
         	 <xsl:template match="type">
         	 	<xsl:param name="rangeId" select="@xmi:idref"/> 
         		<xsl:for-each select="//*[@xmi:id=$rangeId]">
        		 	<h4>Range: <xsl:value-of select="@name"/>(<xsl:value-of select="@UMLType"/>)</h4>
        		 	</xsl:for-each>
        	</xsl:template> 
        	

        	
        	
        	<!--  	
	<xsl:value-of select="$range"/>
					
		        	<xsl:for-each select="">
		        		Range: <xsl:value-of select="@name"/>
		        	</xsl:for-each>
        	
  	<xsl:for-each select="locations/location[id = $eaid]"></xsl:for-each>
 -->

</xsl:stylesheet>
