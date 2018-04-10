<?php

// Load XML file
$xml = new DOMDocument;
$xml->load('modelkatalog.rdf.xml');

// Load XSL file
$xsl = new DOMDocument;
$xsl->load('modelkatalog.xsl.xml');

// Configure the transformer
$proc = new XSLTProcessor;

// Attach the xsl rules
$proc->importStyleSheet($xsl);

echo $proc->transformToXML($xml);
?>