<?php
$servername = "localhost";
$username = "kthcrqqd_robot_user";  // Change this to your MySQL username
$password = "rO]@yDrj~ytr";  // Change this to your MySQL password
$dbname = "kthcrqqd_robot_framework_db";  // Your database name

$conn = new mysqli($servername, $username, $password, $dbname);

if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

?>
