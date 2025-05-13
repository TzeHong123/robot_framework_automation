<?php
header("Content-Type: application/json");
require "db_connect.php"; // Ensure the database connection file is correct

$query = "SELECT id, test_name, status, timestamp FROM test_results ORDER BY id DESC LIMIT 5";
$result = $conn->query($query);

if (!$result) {
    echo json_encode(["error" => "Query failed: " . $conn->error]);
    exit();
}

$data = [];
while ($row = $result->fetch_assoc()) {
    $data[] = $row;
}

echo json_encode($data, JSON_PRETTY_PRINT);
$conn->close();
?>
