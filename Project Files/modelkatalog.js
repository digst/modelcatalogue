	//Hent URL-parametre - ikke pt.
	//var params={};window.location.search.replace(/[?&]+([^=&]+)=([^&]*)/gi,function(str,key,value){params[key] = value;});
	var xml; //inputfil - selve kataloget
	var xsl; //inputfil - transformations-stylesheet
	var nedtrykte = []; //valgte knapper
	
	
	
	$(document).ready(function() {
		displayResult();//vis kataloget
	})
	
	
	/*
	* Knaptræ:
	* opdater knaptræ for hver ny fragment - gem knap-states i variabel
	* generer ny nodepath for hvert klik - brug OR inden for grupper, AND mellem grupper
	* 
	* //rdf:Description[dadk:modelType/@rdf:resource='http://data.gov.dk/model/concepts/ModelTypes#CoreModel'  or dadk:modelType/@rdf:resource='http://data.gov.dk/model/concepts/ModelTypes#LogicalModel']
	*/
	
	
	function displayResult(filterpath)
	{// hent katalog, hent stylesheet, modificer evt stylesheet med filter, lav transformation og vis resultat
		// code for Chrome, Firefox, Opera, etc.
		if (typeof XSLTProcessor !== 'undefined')
		{ //nesting gør loading synkron ved at lade næste trin køre på success-event
			$.get( "modelkatalog.rdf.xml",
			function(data1){	
				xml = data1;
				$.get( "modelkatalog.xsl.xml",
				function(data2){
					xsl  = data2;
					//indsæt filter i stylesheet
					
					if (filterpath ) {$(xsl).find('BODY')[0].firstChild.attributes[0].value = "//rdf:Description[(" + filterpath + ")]";}							
					xsltProcessor = new XSLTProcessor();
					//  console.log ($(xsl).find('BODY')[0].firstChild)
					xsltProcessor.importStylesheet(xsl);
					var resultFragment = xsltProcessor.transformToFragment(xml, document);
					$("#resultatdiv").empty();
					//indsæt resultat i dokument
					document.getElementById("resultatdiv").appendChild(resultFragment);
					$('.enmodel').addClass("klapmodel");//klap alle modeller sammen
					arrows();//tilføj klap ud/ind pile
					sideknapper(filterpath);//lav filterknapper
					searchClick(document.getElementById('searchField').value);							   
				})
			})
		}
		// code for IE
		else
		{
			var source = new ActiveXObject("Msxml2.DOMDocument.3.0");
			source.async = false;
			source.load("modelkatalog.rdf.xml");
			if (source.parseError.errorCode != 0) {
				var myErr = source.parseError;
			} 
			else {
				// Load style sheet.
				var stylesheet = new ActiveXObject("Msxml2.DOMDocument.3.0");
				stylesheet.async = false
				stylesheet.load("modelkatalog.xsl.xml");
				if (filterpath ) {$(stylesheet).find('BODY')[0].firstChild.attributes[0].value = "//rdf:Description[(" + filterpath + ")]";}							
				if (stylesheet.parseError.errorCode != 0) {
					var myErr = stylesheet.parseError;
				} 
				else {
					$("#resultatdiv").empty()
					//indsæt resultat i dokument
					document.getElementById("resultatdiv").innerHTML = source.transformNode(stylesheet);
					$('.enmodel').addClass("klapmodel");//klap alle modeller sammen
					arrows();//tilføj klap ud/ind pile
					sideknapper(filterpath);//lav filterknapper
					searchClick(document.getElementById('searchField').value);	
				}
			}
			
		}
	}
	
	
	
	function sideknapper(filterpath){
		
		$.get( "modelkatalog.rdf.xml",
		function(katData){
			//console.log(katData)
			
			if (filterpath) {katData = $(katData).xpath("//rdf:Description[(" + filterpath + ")]", function(prefix) {
			if (prefix == "dadk"){return "http://data.gov.dk/model/vocabular/modelcat#";}
			if (prefix == "rdf"){return "http://www.w3.org/1999/02/22-rdf-syntax-ns#";}
			if (prefix == "vann"){return "http://purl.org/vocab/vann/";}
			if (prefix == "cc"){return "http://creativecommons.org/ns#";}
			if (prefix == "owl"){return "https://www.w3.org/2002/07/owl#";}
			if (prefix == "dct"){return "http://purl.org/dc/terms/";}
			if (prefix == "dcat"){return "http://www.w3.org/ns/dcat#"}
			if (prefix == "foaf"){return "http://xmlns.com/foaf/0.1/";}
			if (prefix == "adms"){return "http://www.w3.org/ns/adms#";}
			if (prefix == "vcard"){return "http://www.w3.org/2006/vcard/ns#";}
			if (prefix == "skos"){return "http://www.w3.org/2004/02/skos/core#";}
			if (prefix == "schema"){return "http://schema.org/";}
			if (prefix == "rdfs"){return "http://www.w3.org/2000/01/rdf-schema#";}
			
		})}
		//console.log(katData) find("Description,rdf\\:Description")..children().length
		console.log($(katData).length)
		$("#knapdiv").empty()
		
		$(config).each(function(index,theme){
			var overkasse = document.createElement("div");
			var knapkasse = document.createElement("div");
			$(knapkasse).addClass("knapkasse " + theme.boxflex)
			$(overkasse).addClass("overkasse")
			$(overkasse).attr('title', "");
			//var theid = theme.nodePath.substring(theme.nodePath.indexOf(":")+1,theme.nodePath.indexOf("["))
			$(knapkasse).attr({'id': theme.tag,'data-prefix':theme.prefix,'data-klassificeret':theme.klassifikationsfil?true:false});
			
			var navn = document.createTextNode(theme.kasseoverskrift);
			$(overkasse).append(navn);
			$(overkasse).append(knapkasse);
			$("#knapdiv").append(overkasse);
			/*
			* if (tdata){
				var what = "[about='" + key + "'],[rdf\\:about='" + key + "']"
				var title = $(tdata).find(what).find(theme.topicNameLocator)[0].textContent;
			}
			$(theme.targetDiv).append(knap);
			$(knap).on( "click", function( event ) {
				knapklik(event);
			});
			* 
			*/
			
			
			
			if(theme.klassifikationsfil){
				$.get(theme.klassifikationsfil, 
					function(tdata){
						knapfabrik(katData,theme,tdata,knapkasse)
					})
				}
				else{
					knapfabrik(katData,theme,null,knapkasse)
				}
				
			})
			
			/*
			* 
			$.each(nedtrykte,function(){
				$("#" + this).toggleClass("nedtrykt"); 
			})
			*/
		}
	) 
};

function knapfabrik(katData,theme,tdata,kasse){
	//for hvert tema hent klassifikation og brug den som ref, når kataloget gennemgås og push knapper til dokumentet
	//for hvert værdi,antal par i (optalt, grupperet array af ((find alle 'theme'), hvorfra extraheret attribut 0))  laves knap 
	//fremtid: brug _.orderBy til at ordne _countBy efter hyppighed før der each'es
	//"modellingLevel,dadk\\:modellingLevel"
	$.each(_.countBy($(katData).find(theme.tag + "," + theme.prefix + "\\:" + theme.tag).map(function(){return tdata?this.attributes[0].nodeValue:this.textContent})),
	function(buttonTopicID,count){
		console.log(buttonTopicID,count)
		var knap = document.createElement("div");
		knap.className = "knap"
		$(knap).attr('id',buttonTopicID)
		if (tdata){
			var topicLocator = "[about='" + buttonTopicID + "'],[rdf\\:about='" + buttonTopicID + "']"
			//genåbnes for debug
			//console.log(kasse.id,buttonTopicID,topicLocator, theme.topicNameLocator)
			
			var title = $(tdata).find(topicLocator).find(theme.topicNameLocator)[0].textContent;
			$(knap).attr('title', title);
		}
		var label = document.createTextNode(tdata?buttonTopicID.split(theme.splitLocation)[1]:buttonTopicID);
		var count = document.createTextNode(" (" + count + ")");
		$(knap).append(label);
		$(knap).append(count);
		$(kasse).append(knap);
		//console.log($(nedtrykte).find($(knap).attr('id')).length, $(knap).attr('id'))
		
		$.each(nedtrykte, function(a,b){
			if ($(knap).attr('id') == b){$(knap).toggleClass("nedtrykt")}
		});
		$(knap).on( "click", function( event ) {
			knapklik(event);
		});
		
		
		
		//console.log(key,val)
	}
)	
}

function arrows(){//lav fold ud/ind pile på modeldiv
	
	var pilopned = document.createElement("p");
	pilopned.className = "pilopned"
	$(pilopned).attr('title', "Fold ud");
	var label = "&#9660;"
	$(pilopned).append(label);
	$('.enmodel').append(pilopned);
	$('.pilopned').each(function(){
		$(this).on( "click", function( event ) {
			toglModelDisplay(event);
		});
	})
	
}


function toglModelDisplay(clickevent){  //det som sker når man klikker på en foldud/ind trekant - clickevent.target leveres af jquery 'on' funktionen i bearbejd():
//skift pilen
clickevent.target.innerHTML = clickevent.target.innerHTML == "▼" ? "&#9650": "&#9660";
//skift title
clickevent.target.title = clickevent.target.title == "Fold ud" ? "Fold ind": "Fold ud";
//skift class -med jquery-animation
$(clickevent.target.parentNode).toggleClass("klapudmodel",1000)
}

function knapklik(clickevent){ //det som sker når man klikker på en kategoriknap - clickevent.target leveres af jquery 'on' funktionen som knyttes til hver knap af knapfabrikken:
$(clickevent.target).toggleClass("nedtrykt") //skift knappens udseende
nedtrykte = $(".nedtrykt").map(function() { //registrer hvilke knapper der er nedrykte i variablen 'nedtrykte'
return this.attributes['id'].value
})
//$(nedtrykte).each(function(){console.log(this)});
console.log(nedtrykte)
filterByCategory();
}

//Filters the shown elements based on predefined filters within categories such as "Modeltype", "FORMområde" and "Datatema"
function filterByCategory()
{
	var nodePath = $(".knapkasse")
	.map(function(){
		var kassetag = this.id;
		var kasseprefix = this.attributes['data-prefix'].value;
		var kasseklassificeret = this.attributes['data-klassificeret'].value;
		return $(this)
		.find(".nedtrykt")
		.map(function(){
			if(kasseklassificeret == "true"){resource = "/@rdf:resource"} else {resource = ""};
			return kasseprefix + ":" + kassetag + resource + "='" + this.id + "'"
		}
	).get().join(" or ")
}
).filter(function(){
	return this.length > 0;
}
).get().join(") and (");

console.log(nodePath)
displayResult(nodePath);

}

//Triggers on search button click. Goes through all elements of the DOM that has the class ".klapmodel" 
//and checks for a substring containing the search query
function searchClick(query){
	if(query == ""){
		//Please enter search query
	}else
	{
		$('.klapmodel').each(function(){ // For each element
			
			var regex = new RegExp("(" + query+ ")")
			
			var toRemove = $(this).filter(function () {
				if(!regex.test($(this).text()))
				{
					$(this).remove(); // if it is empty, it removes it
				}else
				{
					input = $(this).html();
					matches = input.match(regex);
					//console.log(matches);


					for (let i = 0; i < matches.length; i++) {
						//console.log(`Found ${matches[i]} at ${matches.index}`);
						console.log($(this).html(txt))
						var txt = matches.input.slice(0, matches.index) + "<span class=\"red\">"+ query +"</span>" + matches.input.slice(matches.index + query.length)
						console.log($(this).html(txt))
						$(this).html(txt);
					}				
					//Highlight query text works, but disables drop down function. Also only marks titles, not elements in child nodes
				}
			});
		});
	}
}

//Removes the search query and restores filters if ant where set.
function resetSearch()
{
	filterByCategory();
	document.getElementById('searchField').value = "";
}

//Reset all set filters
function resetFilter()
{
	$.each(nedtrykte, function(a,b){
		if ($(a).attr('id') == b){$(a).toggleClass("nedtrykt")}
	});

	nedtrykte = [];

	displayResult();
}