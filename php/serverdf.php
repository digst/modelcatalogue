<?php
/*
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);
*/
session_start();

if (isset($_SESSION['langID']) && $_SESSION['langID'] == 'da') {
    $filename = 'modelkatalog.rdf';
} else {
    $filename = 'model_catalog.rdf';
}

$finfo = new finfo(FILEINFO_MIME);


header('Content-Description: File Transfer');
header("Content-Type: " . $finfo->file('modelkatalog.rdf.xml'));
header('Content-Disposition: attachmen; filename="' . $filename . '"');
header('Content-Length: ' . filesize('modelkatalog.rdf.xml'));
//readfile('modelkatalog.rdf.xml');


$xml = file_get_contents('modelkatalog.rdf.xml');

echo str_replace('<?xml-stylesheet type="text/xml" href="modelkatalog.xsl.xml"?>', '', $xml);
