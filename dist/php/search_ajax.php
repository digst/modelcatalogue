<?php

/*
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);
*/

//POST Variables
if(isset( $_POST["search-query"])){
    $query = $_POST["search-query"];
}

if(isset( $_POST["language"])){
    $language = $_POST["language"];
}

if(isset( $_POST["filters"])){
    $filters = $_POST["filters"];
}

if(isset( $_POST["filtersAll"])){
    $filtersAll = $_POST["filtersAll"];
}


	session_start();
	$_SESSION['langID'] = $language;
//Globals
$searchHits = 0;

// --------------------------------------------------------------------------------------------------------------------------------
//Entrypoint
// --------------------------------------------------------------------------------------------------------------------------------
//If query is supplied --> search then filter
//Otherwise --> filter without search
// --------------------------------------------------------------------------------------------------------------------------------
if($query != ""){
    applySearch();
}else{
    applyFilter();
}

// --------------------------------------------------------------------------------------------------------------------------------
// Purpose -->  
//              Searches the given xml document for occurrences of a search query
// --------------------------------------------------------------------------------------------------------------------------------
// Arguments -->
//              $xml --> xml or string formatted xml document on which to run the search query.
// --------------------------------------------------------------------------------------------------------------------------------
function applySearch($xml = "../xml/modelkatalog.rdf.xml"){

    global $query;
    global $language;
    global $searchHits;

    $counter = 0;
	

    
    $xslDoc = ($language == 'da'? '../xml/modelkatalog.xsl.xml': '../xml/modelkatalog_eng.xsl.xml');
    //$xslDoc = '../xml/modelkatalog.xsl.xml';
    
    $searchResultXML = '<?xml version="1.0" encoding="UTF-8"?><?xml-stylesheet type="text/xml" href="modelkatalog.xsl.xml"?><rdf:RDF xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" xmlns:dadk="http://data.gov.dk/model/vocabular/modelcat#" xmlns:mreg="http://data.gov.dk/model/vocabular/modelcat#" xmlns:mlev="http://data.gov.dk/model/vocabular/modelcat#" xmlns:vann="http://purl.org/vocab/vann/" xmlns:cc="hhttp://creativecommons.org/ns#" xmlns:owl="https://www.w3.org/2002/07/owl#" xmlns:dct="http://purl.org/dc/terms/" xmlns:dcat="http://www.w3.org/ns/dcat#" xmlns:foaf="http://xmlns.com/foaf/0.1/" xmlns:adms="http://www.w3.org/ns/adms#" xmlns:vcard="http://www.w3.org/2006/vcard/ns#" xmlns:skos="http://www.w3.org/2004/02/skos/core#" xmlns:schema="http://schema.org/" xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#">';
    
    $tmp = simplexml_load_file($xml);

    //Find all datasets which contain the search query - Non case sensitive
    foreach($tmp->xpath('//rdf:Description') as $node) {
        if($counter == 1 ){
            break;
        }
        foreach($node->xpath('//rdf:Description') as $child){
            if(preg_match("/".$query."/i", $child->asXML())){
                $searchResultXML .= $child->asXml();
                $searchHits++;
            }
        }
        $counter++;
    }
    
    $searchResultXML .= "</rdf:RDF>";

    $result = simplexml_load_string($searchResultXML);

    applyFilter($result, 0, true);
}

// --------------------------------------------------------------------------------------------------------------------------------
// Purpose --> 
//              Applies a filter to the given xml document
// --------------------------------------------------------------------------------------------------------------------------------
// Arguments -->
//              $xml --> xml or string formatted xml document on which to run the filtering.
//              $counter --> keeps track of the current iteration of the recursive fuction. Serves to break recursion once base case is reached.
//              $filtered --> holds a boolean used to reason about whether an xml document should be read as a string or xml. If true xml is already converted to string else the xml must be loaded
// --------------------------------------------------------------------------------------------------------------------------------
// Returns --> 
//              a filtered and xsl transformed xml document as well as an an array of key/value pairs describing the amount of occurrences for each filter
// --------------------------------------------------------------------------------------------------------------------------------
function applyFilter($xml = "../xml/modelkatalog.rdf.xml", $counter = 0, $filtered = false){

    global $filters;
    global $language;
    global $searchHits;

    //Recursive base case
    if($counter == sizeof($filters)){

        $xslDoc = ($language == 'da'? '../xml/modelkatalog.xsl.xml': '../xml/modelkatalog_eng.xsl.xml');

        //$xslDoc = '../xml/modelkatalog.xsl.xml';

        // Load XSL file
        $xsl = new DOMDocument;
        $xsl->load($xslDoc);

        // Configure the transformer
        $proc = new XSLTProcessor;
    
        // Attach the xsl rules
        $proc->importStyleSheet($xsl);

        $returnArr = [$proc->transformToXML($xml), updateFilters($xml), $searchHits];

        echo json_encode($returnArr);

    }else{

        $searchHits = 0;

        $searchResultXML = '<?xml version="1.0" encoding="UTF-8"?><?xml-stylesheet type="text/xml" href="modelkatalog.xsl.xml"?><rdf:RDF xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" xmlns:dadk="http://data.gov.dk/model/vocabular/modelcat#" xmlns:mreg="http://data.gov.dk/model/vocabular/modelcat#" xmlns:mlev="http://data.gov.dk/model/vocabular/modelcat#" xmlns:vann="http://purl.org/vocab/vann/" xmlns:cc="hhttp://creativecommons.org/ns#" xmlns:owl="https://www.w3.org/2002/07/owl#" xmlns:dct="http://purl.org/dc/terms/" xmlns:dcat="http://www.w3.org/ns/dcat#" xmlns:foaf="http://xmlns.com/foaf/0.1/" xmlns:adms="http://www.w3.org/ns/adms#" xmlns:vcard="http://www.w3.org/2006/vcard/ns#" xmlns:skos="http://www.w3.org/2004/02/skos/core#" xmlns:schema="http://schema.org/" xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#">';

        if($filtered){
            $tmp = $xml;
        }else{
            $tmp = simplexml_load_file($xml);
        }

        //Apply filter to xml document
        foreach($tmp->xpath($filters[$counter]) as $node) {
            $searchResultXML .= $node->asXml();
            $searchHits++;
        }

        $searchResultXML .= "</rdf:RDF>";
        
        $result = simplexml_load_string($searchResultXML);

        $counter = $counter + 1;

        $filtered = true;

        //Recursive function call on the filtered xml
        applyFilter($result, $counter, $filtered);
    }
}

// --------------------------------------------------------------------------------------------------------------------------------
// Purpose --> 
//              Retireves the amount of occurrences of a all filters in an xml document
// --------------------------------------------------------------------------------------------------------------------------------
// Arguments -->
//              $xml --> string formatted xml document on which to run the filtering
// --------------------------------------------------------------------------------------------------------------------------------
// Returns --> 
//              an array of key/value pairs describing the amount of occurrences for each filter
// --------------------------------------------------------------------------------------------------------------------------------
function updateFilters($xml) : array{

    global $filtersAll;

    $occurrences = array();

    for ($i=0; $i < sizeof($filtersAll); $i++) { 
        $filter_occurrences = count($xml->xpath($filtersAll[$i]));

        $occurrences = array_merge($occurrences, array($filtersAll[$i] => $filter_occurrences));
    }

    return $occurrences;
}