<?xml version="1.0" encoding="UTF-8"?>

<!-- New document created with EditiX at Mon Feb 24 15:34:47 CET 2020 -->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:output method="html"/>
	
	<xsl:template match="/">
	<html>
		<head> 
  			  <title> 
  				  Pays du monde 
  			</title> 
 		</head> 
 
 		<body style="background-color:white;">  
  			<h1>Les pays du monde</h1> 
			Mise en forme par : Jérôme Hue , Damien Carreau (B3321)
   			<xsl:apply-templates select="//metadonnees"/>
			   
			<p>
			   
			Pays aves 6 voisins : 
			   
			<xsl:for-each select="//country[borders[count(neighbour) = 6]]/name/common">	  
				<xsl:value-of select = "." />,    
			</xsl:for-each>
			   
			</p>
			   
			   
			Pays ayant le plus de voisins : 
			   
			<xsl:for-each select="//country">
         		<xsl:sort select="count(borders/neighbour)" data-type="number" order="descending"/>
         			<xsl:if test="position()=1">
         				<xsl:value-of select="name/common"/> (<xsl:value-of select="count(borders/neighbour)"/>)
         			</xsl:if>
         	</xsl:for-each>
         					
			   
			
			   
			<hr/>
			
			<xsl:for-each select="//continent[not(preceding::continent/. = .)]">	
			   
					
				<xsl:variable name="cont" select="." /> 
				
				<h3>Pays du continent : <xsl:value-of select = "." /> par sous régions :  </h3>
					
				<xsl:for-each select="//infosContinent[continent = $cont]/subregion[not(preceding::subregion/. = .)]">	
							
					<xsl:variable name="subregion" select="." /> 
					
					<h4>
									 <xsl:value-of select = "." /> 
									(<xsl:value-of select = "count(//country/infosContinent[subregion = $subregion])"/> pays)	
					</h4>
								
					<table border="3" width="100%" align="center">
					
						<tr>
									<th>N°</th>
									<th>Nom</th>
									<th>Capitale</th>
									<th>Voisins</th>
									<th>Coordonnées</th>
									<th>Drapeau</th>
						</tr>
						
						<xsl:apply-templates select="//country[infosContinent/subregion = $subregion]"/>
					</table>
							
				</xsl:for-each>
						
					
				  
			</xsl:for-each>
			   
			 
			  
 		</body> 
	</html>
</xsl:template>

<xsl:template match="metadonnees">
 <p style="text-align:center; color:blue;">
	Objectif : <xsl:value-of select="objectif"/>
 </p><hr/><hr/>
</xsl:template>

<xsl:template match="country">
		
			
			
				<tr>
				
				<td>
								<xsl:value-of select="position()"/>
				</td>
			
				<td>
	         		 <SPAN style="color:green">
	         			<xsl:value-of select="./name/common"/>
	         		</SPAN>
	         		(<xsl:value-of select="./name/official"/>)
								
					<br/>
								
					<xsl:if test="name/native_name/@lang = 'eng'">
			     		   	    <SPAN style="color:    blue">
			        			      	 <xsl:text>Nom Anglais : </xsl:text>
			        			     	  (<xsl:value-of select="name/native_name[@lang='eng']/official"  />)
			        			       </SPAN>
		        				 </xsl:if>
							</td>
        				 
        				 
        				 <td><xsl:value-of select="capital"/>  </td>
        				 
        				 <td>
        				 <xsl:for-each select=".">
        				 	<xsl:if test="(not(borders)) and landlocked='false' ">
        				 		Île
        				 	</xsl:if>
        				 	<xsl:if test="(borders) ">
        				 	
        				 		<xsl:for-each select="borders/neighbour">
        				 		
        				 			<xsl:variable name= "var1" select="."/>
        				 			
        				 				<xsl:for-each select="//country">
        				 				
        				 				<xsl:if test="codes/cca3 = $var1">
        				 					<xsl:value-of select="name/common"/>,
        				 					
        				 				</xsl:if>
        				 				</xsl:for-each>
        				 		</xsl:for-each>
        				 		 
        				 	</xsl:if>
        		
        				 
        				 <br/>
        				  </xsl:for-each>
  
        				 </td>
        				 
        				 <td>
        				 Latitude :   <xsl:value-of select="coordinates/@lat"/>
        				 <br/>
        				 Longitude :  <xsl:value-of select="coordinates/@long"/>
        				 </td>
        				 
        				 <td>
        				 
        				<xsl:variable name="lowercase" select="'abcdefghijklmnopqrstuvwxyz'" />
						<xsl:variable name="uppercase" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'" />


	
 
        				 <xsl:variable name= "var2" select="translate(codes/cca2,$uppercase ,$lowercase)"/>
        				 <img src = "{ concat ( 'http://www.geonames.org/flags/x/',  $var2, '.gif' ) } " alt=""  height="40" width="60"/> 
        				 
        				 </td>

     			   </tr>
     		   
     		 
     		

</xsl:template>




</xsl:stylesheet>
