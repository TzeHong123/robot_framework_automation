<?php
error_reporting(E_ALL);
ini_set('display_errors', 1);
header('Content-Type: application/json');

$input = file_get_contents("php://input");
$data = json_decode($input, true);

// Debug: Log incoming data
file_put_contents("php_debug.log", "Received: " . print_r($data, true), FILE_APPEND);

if (!isset($data["tests"])) {
    echo json_encode(["error" => "No tests provided"]);
    exit;
}

$tests = $data["tests"];
$results = [];

// DATABASE CONNECTION
include 'db_connect.php';

$conn = new mysqli($servername, $username, $password, $dbname);

// Check connection
if ($conn->connect_error) {
    file_put_contents("php_debug.log", "DB Connection Error: " . $conn->connect_error, FILE_APPEND);
    die(json_encode(["error" => "Database connection failed"]));
}

foreach ($tests as $test) {
    $status = "success";
    $message = "Test executed";
    
    // Generate unique IDs for log and report files
    $unique_id = uniqid();
    $log_file = "log_{$unique_id}.html";
    $report_file = "report_{$unique_id}.html";

    // Insert into database
    $sql = "INSERT INTO test_results (test_name, status, message, log_file, report_file) VALUES (?, ?, ?, ?, ?)";
    $stmt = $conn->prepare($sql);
    if ($stmt) {
        $stmt->bind_param("sssss", $test, $status, $message, $log_file, $report_file);
        if (!$stmt->execute()) {
            file_put_contents("php_debug.log", "SQL Insert Error: " . $stmt->error, FILE_APPEND);
        }
        $stmt->close();
    }

    $results[] = [
        "test_name" => $test,
        "status" => $status,
        "message" => $message,
        "log_file" => $log_file,
        "report_file" => $report_file
    ];
}

// Debug: Log what was inserted
file_put_contents("php_debug.log", "Inserted: " . print_r($results, true), FILE_APPEND);

$conn->close();
echo json_encode($results);
?>
