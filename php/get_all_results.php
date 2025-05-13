<?php
header("Content-Type: application/json");
require_once "db_connect.php"; // Ensure correct DB connection

$response = array();

try {
    $query = "SELECT id, test_name, status, timestamp, log_file, report_file FROM test_results ORDER BY id ASC";
    $stmt = $conn->prepare($query);
    $stmt->execute();
    $results = $stmt->get_result()->fetch_all(MYSQLI_ASSOC);

    if (!$results) {
        throw new Exception("No test results found.");
    }

    echo json_encode($results);
} catch (Exception $e) {
    echo json_encode(["error" => $e->getMessage()]);
}
?>
