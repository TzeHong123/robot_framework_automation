<?php
header("Content-Type: application/json");
require_once "db_connect.php"; // Ensure the correct database connection file is used

$response = array();

try {
    // Retrieve the latest test result ID
    $query = "SELECT id FROM test_results ORDER BY id DESC LIMIT 1";
    $stmt = $conn->prepare($query);
    $stmt->execute();
    $result = $stmt->get_result()->fetch_assoc();

    if (!$result) {
        throw new Exception("No test results found.");
    }

    $latest_id = $result["id"];

    // Get JSON input
    $data = json_decode(file_get_contents("php://input"), true);
    $log_file = isset($data["log_file"]) ? $data["log_file"] : null;
    $report_file = isset($data["report_file"]) ? $data["report_file"] : null;

    if (!$log_file || !$report_file) {
        throw new Exception("Missing log_file or report_file.");
    }

    // Update only the latest row
    $updateQuery = "UPDATE test_results SET log_file = ?, report_file = ? WHERE id = ?";
    $updateStmt = $conn->prepare($updateQuery);
    $updateStmt->bind_param("ssi", $log_file, $report_file, $latest_id);
    
    if ($updateStmt->execute()) {
        $response["success"] = true;
        $response["message"] = "Test result updated successfully.";
    } else {
        throw new Exception("Failed to update test result.");
    }
} catch (Exception $e) {
    $response["success"] = false;
    $response["error"] = $e->getMessage();
}

// Return JSON response
echo json_encode($response);
?>
