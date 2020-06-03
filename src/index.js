import _ from 'lodash';
import * as DKFDS from "dkfds";
const tippy = require('tippy.js').default;
import 'tippy.js/dist/tippy.css';
import './style.css';

var $ = require("jquery");
var config = da_config;


$(function(){
	/*********************************
	 ***   Initialize aplication   ***
	 *********************************/
	DKFDS.init();	
	initializeFilterBtns();
	displayResult();
	
	
	/*********************************
	 ***   		Add events   	   ***
	 *********************************/
	
	/*** Toggle language ***/
	$( "header" ).on( "click", ".langSelect", function() {
		// set focus on selected language
		$('.langSelect').removeClass('focus');
		$(".langSelect[lang='"+$(this).attr( "lang" )+"']").addClass('focus');
		
		//switch content and navigation
		$.get("./ajax/"+$(this).attr( "lang" )+"_content.html", function(data, status){
			
			$(".page-content").html(data);
			config = $(this).attr( "lang" ) == 'da' ? da_config : en_config; 
			initializeFilterBtns();
			displayResult();
			
		},'html');
		
		$.get("./ajax/"+$(this).attr( "lang" )+"_navigation.html", function(data, status){
			$(".navbar-inner").html(data);
		},'html');
		
		$.get("./ajax/"+$(this).attr( "lang" )+"_footer.html", function(data, status){
			$("footer").html(data);
		},'html');
		
		//
	});
	
	/*** Toggle filterpanel ***/
	$( "main" ).on( "click", ".toggleFilter", function() {
		$('.sidepanel').css('display') == "block" ? $('.sidepanel').hide(): $('.sidepanel').show();
	});
	
	/*** Submit search  ***/
	$( "main" ).on( "click", ".do-search", function(e) {
		e.preventDefault();
		displayResult();
	});
	
	/*** Reset search  ***/
	$( "main" ).on( "click", ".reset-search", function(e) {		
		e.preventDefault();
		$("input[name='search-query']").val("");
		displayResult();
	});
	
	/*** Reset filters  ***/
	$( "main" ).on( "click", ".reset-filter", function(e) {	
		e.preventDefault();
		$("input[name='filters[]']").remove();
		$('.tag-active').removeClass('tag-active');
		displayResult();
	});
	
	
		
});
	
function initializeFilterBtns(){
	$("#knapdiv").empty();
	$.get( "xml/modelkatalog.rdf.xml",
	function(katData){
		$(config).each(function(index,theme){
			var overkasse = $("<div>", {"class": "overkasse"}).append(theme.kasseoverskrift);
			var knapkasse =  $("<div>", {"id": theme.tag,'data-prefix':theme.prefix,'data-klassificeret':theme.klassifikationsfil?true:false,"class": "knapkasse " + theme.boxflex});
			$("#knapdiv").append(overkasse.append(knapkasse));

			if(theme.klassifikationsfil){
				$.get(theme.klassifikationsfil, 
					function(tdata){
						createBtns(katData,theme,tdata,knapkasse)
					});
			}
			else{
				createBtns(katData,theme,null,knapkasse)
			}
		});
	});
	
}

function createBtns(katData,theme,tdata,kasse){

	$.each(_.countBy($(katData).find(theme.tag + "," + theme.prefix + "\\:" + theme.tag).map(function(){return tdata?this.attributes[0].nodeValue:(theme.tag=='publisher'?this.children[0].	children[0].textContent:this.textContent)})),
	function(buttonTopicID,count){
		//Do not create buttons with no ID or Text
		if((tdata?buttonTopicID.split(theme.splitLocation)[1]:buttonTopicID) != '' && buttonTopicID != '' ){
			if (tdata){
				var topicLocator = "[about='" + buttonTopicID + "'],[rdf\\:about='" + buttonTopicID + "']"	
				try {
					var title = $(tdata).find(topicLocator).find(theme.topicNameLocator)[0].textContent;
				} catch (error) {}
			}
				
			var btntext = (tdata?buttonTopicID.split(theme.splitLocation)[1]:buttonTopicID);
			
			//Truncate button text
			if(!title && btntext.length >= 22 ){
				title = btntext;
				btntext = btntext.substring(0,22)+"... (" + count + ")";
			}else
				btntext = btntext + " (" + count + ")";
			
			var xpath ="//rdf:Description[("+($(kasse).attr('data-prefix') + ":" + $(kasse).attr('id') +( 
						$(kasse).attr('id') == 'publisher' ?  '/foaf:Agent/foaf:name[text()="' + buttonTopicID +'"]'
							:($(kasse).attr('data-klassificeret') == 'true' ? "\/@rdf:resource" : "" )+ "='" + buttonTopicID))+"')]";
							
							if($(kasse).attr('id') == 'publisher'){
								xpath = xpath.replace("//rdf:Description[(", "//rdf:Description[");
								xpath = xpath.replace("')]", "]");
							}
			
			var knap = $("<button>",{"id": buttonTopicID,"class": title?"tag js-tippy":"tag","data-tippy-content": title,"data-filter-xpath" : xpath}).append(btntext);
			
			var input = $("<input>",{"type" : "hidden", "name" : "filtersAll[]", "value" : xpath });
			$("#search-form").append(input);
			
			$(kasse).append(knap);
			if(title)
				tippy(".js-tippy");
			
			$(knap).on( "click", function( event ) {
				
				var filterBtn = $(event.target); 
				filterBtn.toggleClass("tag-active");
				
				//Add / Remove filter input from form
				if($("input[id='inp_"+$(event.target).attr('id')+"']").length<1){
					$("input[id='inp_def_filter']").remove();

					var input = $("<input>",{"type" : "hidden", "name" : "filters[]", "value" : $(event.target).attr('data-filter-xpath'), "id" : "inp_" +$(event.target).attr('id')  });
					$("#search-form").append(input);
					
					$('html, body').animate({
						scrollTop: $("#search-form").offset().top
					}, 1000);
					
				}
				else
					$("input[id='inp_"+filterBtn.attr('id')+"']").remove();
				
				 displayResult();
			});
		}
	});	
}

function displayResult()
{
	//Set xsl from language
	var doc = $('.langSelect.focus').attr( "lang" ) == 'da' ? 'xml/modelkatalog.xsl.xml' : 'xml/modelkatalog_eng.xsl.xml';
	
	//Set default filter if no filter is set
	if($("input[name='filters[]']").length<1){
		var input = $("<input>",{"type" : "hidden", "name" : "filters[]", "value" : "//rdf:type[@rdf:resource='http://www.w3.org/ns/dcat#Dataset' ]/..", "id" : "inp_def_filter"  })
		$("#search-form").append(input);
	}

	$.get( "xml/modelkatalog.rdf.xml",
		function(data1){	
			var xml = data1;
			$.get( doc,
			function(data2){
				var xsl  = data2;	
				
				//Updates the view
				$.ajax({
					type: "POST",
					url: 'php/search_ajax.php',
					
					data: $('#search-form').serialize(),
					
					success: function(output){
						var json = $.parseJSON(output);
						//var json = JSON.parse(output);
						//console.log(output);
						$("#resultatdiv").html(json[0]);
						$('.enmodel').addClass("klapmodel");//klap alle modeller sammen
						$('.enmodel').addClass("klapmodel1");//klap alle modeller sammen  	*/  
						
						var resultcount = $("<div>",{"class" : "resultCount"}).append(json[2] != '1' ? "<strong>"+json[2]+"</strong> resultater" : "<strong>"+json[2]+"</strong> resultat");
						$("#resultatdiv").prepend(resultcount);
						
						var hasfilters = false;
						var filtersSet = $("<div>",{"class" : "filtersSet"});
						
						var length = $(".tag-active").length;
						$(".tag-active").each(function(index){
							hasfilters = true;
							if (index === (length - 1)) 
							$(filtersSet).append($(this).html().substr(0,$(this).html().indexOf('(')));
						else
							$(filtersSet).append($(this).html().substr(0,$(this).html().indexOf('('))+", ");
						});
						if(hasfilters){
							$(filtersSet).prepend("<strong>Filtrering på:</strong> ");
							$("#resultatdiv").prepend(filtersSet);
						}
						arrows();
						updateFilterBtns(json[1]);
					}
				});

			});
		});
}


function arrows(){

	$('h2.model-heading').each(function(){
		$(this).prepend("<div class='model-header'></div>");
		$('<p />', {'class' : 'pilopned', text : '▼',appendTo : this});
	});
	
	var pilopned = $("<p>",{"class" : "pilopned", "title" : "Fold ud"}).append("&#9660;"); 
	$('.card-header .header-title').append(pilopned);
		
	$('.model-header').each(function(){
		$(this).parent().attr('title', "Fold ud");
		$(this).on( "click", function( event ) {
			toglModelDisplayHeader(event);
		});
	});
	$('.card-header .header-title p').each(function(){
		$(this).parent().attr('title', "Fold ud");
		$(this).on( "click", function( event ) {
			toglModelDisplaySub(event);
		});
	});
}

function toggleOverlay(){
	$('.overlay').toggleClass('is-visible');
	
	
}

function updateFilterBtns(btns){
	
	$("button.tag").each(function(){
		
		var count = btns[$(this).attr('data-filter-xpath')];
		var btnText = $(this).html();
		btnText = btnText.substr(0,btnText.indexOf('('))+ " ("+ count + ")";
		$(this).html(btnText);
		
		$(this).attr("data-filter-count",count);
		
		if(count == 0){
			$(this).attr("disabled", "disabled");
			$(this).addClass('disabled');
		}
		else{
			$(this).removeAttr("disabled");
			$(this).removeClass("disabled");
		}
		
	});
	
}


function toglModelDisplayHeader(clickevent){  
clickevent.target.parentNode.querySelector('p').innerHTML = clickevent.target.parentNode.querySelector('p').innerHTML == "▼" ? "&#9650": "&#9660";
clickevent.target.parentNode.title = clickevent.target.parentNode.title == "Fold ud" ? "Fold ind": "Fold ud";
$(clickevent.target).parent().parent().toggleClass("klapudmodel",1000);

}

function toglModelDisplaySub(clickevent){
	$(clickevent.target).closest('.card').toggleClass("klapudmodel");
	var arrow = $(clickevent.target).html() == "▼" ? "&#9650": "&#9660"; 
	$(clickevent.target).html(arrow);
}
