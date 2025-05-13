<?php
include 'db_connect.php';

// Connect to the database
$conn = new mysqli($servername, $username, $password, $dbname);

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Read incoming JSON data
$data = json_decode(file_get_contents("php://input"), true);
$test_name = $data['test_name'];
$status = $data['status'];
$message = $data['message'];
$timestamp = date('Y-m-d H:i:s');

// Insert into the database
$sql = "INSERT INTO test_results (test_name, status, message, timestamp) VALUES ('$test_name', '$status', '$message', '$timestamp')";
if ($conn->query($sql) === TRUE) {
    echo json_encode(["success" => true, "message" => "Test result saved successfully"]);
} else {
    echo json_encode(["success" => false, "error" => $conn->error]);
}

// Close connection
$conn->close();
?>
