<?php
//
// DO NOT MODIFY OR SUBMIT THIS FILE.
// 

// Enable Error Reporting
error_reporting(E_ALL);
ini_set('display_errors', 1);

// Load DB Credentials
require 'db.php';

// Load GET params
$n = getDBparam($_GET["n"] ?? NULL);

// If there are no uncaught errors, then return type is JSON
if (error_get_last()==NULL)
  header('Content-type: application/json');

// Call procedure
echo query2JSON("CALL Inspections_by_Technician($n)");

?>