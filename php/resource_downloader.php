<?php
    ini_set('display_errors', 1);
    ini_set('display_startup_errors', 1);
    error_reporting(E_ALL);
    
    //POST Variables
    if(isset( $_GET["url"])){
        $url = $_GET["url"];
    }

    /*echo get_domain($url);
    echo "Own Domain";

    if(get_domain($url) == "https://data.gov.dk"){
        echo "Own Domain";
        //$file = fopen( $url, 'r' );
    }else{
        $file = fopen( $url, 'r' );
    }
    */
    
    $file = fopen($url, 'r');

    $name = basename($url);

    header('Content-Description: File Transfer');
    header('Content-Type: application/octet-stream');
    header('Content-Disposition: attachment; filename=' . $name);
    header('Content-Transfer-Encoding: binary');
    header('Expires: 0');
    header('Cache-Control: must-revalidate');
    header('Pragma: public');
    header('Content-Length: ' . filesize($file));
    ob_clean();
    flush();
    readfile($file);
    exit;

    /*function get_domain($url)
    {
        $pieces = parse_url($url);
        $domain = isset($pieces['host']) ? $pieces['host'] : $pieces['path'];
        if (preg_match('/(?P<domain>[a-z0-9][a-z0-9\-]{1,63}\.[a-z\.]{2,6})$/i', $domain, $regs)) {
            return $regs['domain'];
        }
        return false;
    }*/
