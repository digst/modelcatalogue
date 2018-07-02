<?php

$xslDoc = $_POST['lang']; 

if(isset($_POST['filter'])){
    $filterpath = $_POST['filter'];
}else {
    $filterpath = "";
}

// Load XML file
$xml = new DOMDocument;
$xml->load('../xml/modelkatalog.rdf.xml');

// Load XSL file
$xsl = new DOMDocument;
$xsl->load($xslDoc);

$xpath = new DOMXPath($xsl);

if($filterpath != ""){
    $xsl->getElementsByTagName("BODY")->item(0)->childNodes->item(0)->setAttribute('select', "//rdf:Description[(" . $filterpath . ")]");
    //$node = $node[0]->getAttribute('select');
    //echo "TEST" . $node;
    //$node = "//rdf:Description[(" . $filterpath . ")]";
    //VAR_DUMP($node);
    //$xsl ->loadXML($node);
}

// Configure the transformer
$proc = new XSLTProcessor;

// Attach the xsl rules
$proc->importStyleSheet($xsl);

echo $proc->transformToXML($xml);
?>