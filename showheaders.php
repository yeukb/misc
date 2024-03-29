<p>The following headers were sent to the server:</p>
<?php

$localIPAddress = getHostByName(getHostName());
echo '<strong>'. "local IP" .'</strong>: '. $localIPAddress .'<br />';

date_default_timezone_set("Asia/Singapore");
/* $currentTime = date("Y-m-d l h:i:sa"); */
$currentTime = date("Y-m-d l H:i:s");
$currentUsec = gettimeofday()["usec"];
echo '<strong>' . "Current Time" . '</strong>: ' . $currentTime . '.' . $currentUsec . '<br />';

/* All $_SERVER variables prefixed with HTTP_ are the HTTP headers */
foreach ($_SERVER as $header => $value) {
  if (substr($header, 0, 5) == 'HTTP_') {
    /* Strip the HTTP_ prefix from the $_SERVER variable, what remains is the header */
    $clean_header = strtolower(substr($header, 5, strlen($header)));

    /* Replace underscores by the dashes, as the browser sends them */
    $clean_header = str_replace('_', '-', $clean_header);

    /* Cleanup: standard headers are first-letter uppercase */
    $clean_header = ucwords($clean_header, " \t\r\n\f\v-");

    /* And show'm */
    echo '<strong>'. $header .'</strong>: '. $value .'<br />';
  }
}

foreach ($_SERVER as $header => $value) {
  if (substr($header, 0, 7) == 'REMOTE_') {
    /* Strip the HTTP_ prefix from the $_SERVER variable, what remains is the header */
    $clean_header = strtolower(substr($header, 7, strlen($header)));

    /* Replace underscores by the dashes, as the browser sends them */
    $clean_header = str_replace('_', '-', $clean_header);

    /* Cleanup: standard headers are first-letter uppercase */
    $clean_header = ucwords($clean_header, " \t\r\n\f\v-");

    /* And show'm */
    echo '<strong>'. $header .'</strong>: '. $value .'<br />';
  }
}

?>
