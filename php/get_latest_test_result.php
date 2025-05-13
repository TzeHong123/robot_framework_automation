<?php
header("Content-Type: application/json");
require_once "db_connect.php"; // Include database connection

$response = array();

try {
    // Fetch the latest test result
    $query = "SELECT id FROM test_results ORDER BY id DESC LIMIT 1";
    $stmt = $conn->prepare($query);
    $stmt->execute();
    $result = $stmt->get_result()->fetch_assoc();

    if ($result) {
        $response["success"] = true;
        $response["id"] = $result["id"];
    } else {
        $response["success"] = false;
        $response["message"] = "No test results found.";
    }
} catch (Exception $e) {
    $response["success"] = false;
    $response["error"] = $e->getMessage();
}

// Return JSON response
echo json_encode($response);
?>
