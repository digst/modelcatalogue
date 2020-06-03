<?php 

ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

session_start();

if($_SESSION['langID'] == 'da')
	$xsl = '<?xml-stylesheet type="text/xml" href="modelkatalog.xsl.xml"?>';
else 
	$xsl = '<?xml-stylesheet type="text/xml" href="modelkatalog_eng.xsl.xml"?>';

$finfo = new finfo(FILEINFO_MIME);

//header('Content-Description: File Transfer');
header("Content-Type: " . $finfo->file('modelkatalog.rdf.xml'));

//readfile('modelkatalog.rdf.xml');


$xml = file_get_contents('modelkatalog.rdf.xml');

echo str_replace('<?xml version="1.0" encoding="UTF-8"?>','<?xml version="1.0" encoding="UTF-8"?>'.$xsl,$xml);


