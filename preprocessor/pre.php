<?php

// check arguments
if (count($argv) != 2){
    echo 'Usage: pre.php <file.c>';
    exit(1);
}

// get filename
$filename = $argv[1];

// file exists ?
if (!file_exists($filename)){
  exit(1);
}

// get content
$data = file_get_contents($filename);

// global array of filter functions
$filter = array();

// get filter function within current dir *.macro.php*
$files = scandir(__DIR__);

foreach ($files as $file){
  // load filter function
  if (substr($file, -10) == '.macro.php'){
    $filter[] = require($file);
  }
}

// apply filter functions
foreach ($filter as $f){
   $data = $f($data);
}

// output filtered data
echo $data;

// done!
exit(0);
