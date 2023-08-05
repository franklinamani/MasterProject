<?php 
//
// DO NOT MODIFY OR SUBMIT THIS FILE.
// 

function query2JSON($queryString) {
    
  // Connect to DB & catch exceptions
  try {
    $db = openDB();
  } catch (Exception $e) {
    return json_encode(array("status"=>"DB Connect Failure","reason"=>$e->getMessage()),JSON_PRETTY_PRINT);
  }

  // Temporary 2D array to store result table
  $output = [[]];  

  try {
    // Execute Query
    if($result = $db->query($queryString)) {

        // Write the Column Names
        $fields = $result->fetch_fields();
        foreach ( $fields as $field ) {
          $output[0][] = $field->name;
        }

        // Fetch and store each result row
        while ($row = $result->fetch_row()) {
          $output[]=$row;
        }

        // Free result
        $result->free();
    
    } else {
      return json_encode(array("status"=>"Query Failure", "query"=>$queryString, "message"=>"$db->error"), JSON_PRETTY_PRINT);
    }
  }  catch (Exception $e) {
    return json_encode(array("status"=>"Query Failure","query"=>$queryString,"message"=>$e->getMessage()),JSON_PRETTY_PRINT);
  }
  // Close DB connection
  closeDB($db);
  return json_encode($output, JSON_PRETTY_PRINT);

}

function getDBparam($param) {
  
  // Connect to DB & catch exceptions
  try {
    $db = openDB();
  } catch (Exception $e) {
    return json_encode(array("status"=>"DB Connect Failure","reason"=>$e->getMessage()),JSON_PRETTY_PRINT);
  }
  
  $escapedParam = $db->real_escape_string($param);
  
  closeDB($db);

  return $escapedParam;
}

function openDB()
{
  try
  {

    ob_start(); // Surpress error messages

    $db = new mysqli( $GLOBALS['server'],
                      $GLOBALS['username'],
                      $GLOBALS['password'],
                      $GLOBALS['schema'],
                      $GLOBALS['port']);

    ob_end_clean(); // Cleanup error messages that were captured

    if ($db->connect_errno) {
      $error = "Failed to connect to MySQL: (" . $db->connect_errno . ") " . $db->connect_error;
      error_clear_last();
      throw new Exception($error);
    }

    return $db;

  }
  catch (mysqli_sql_exception $e)
  {
    ob_end_clean(); // Cleanup error messages that were captured
    $error = "Failed to connect to MySQL: ".$e->getMessage();
    error_clear_last();
    throw new Exception($error);
  }

  return NULL;
}

function closeDB($db)
{
  if ($db !=NULL )
    $db->close();
}

if(file_exists('credentials.php'))
    include 'credentials.php';

if(isset($_GET["server"]))
  $server = $_GET["server"];
if(isset($_GET["username"]))
  $username = $_GET["username"];
if(isset($_GET["password"]))
  $password = $_GET["password"];
if(isset($_GET["db"]))
  $schema = $_GET["db"];
if(isset($_GET["port"]))
  $schema = $_GET["port"];

?>
