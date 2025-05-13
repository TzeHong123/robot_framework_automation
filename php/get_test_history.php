<?php
include 'db_connect.php';

$sql = "SELECT * FROM test_history ORDER BY execution_time DESC";
$result = $conn->query($sql);

$history = [];
while ($row = $result->fetch_assoc()) {
    $history[] = $row;
}

header('Content-Type: application/json');
echo json_encode($history);

$conn->close();
?>
