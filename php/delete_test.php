<?php
require 'db_connect.php'; // Ensure this connects to your database

if ($_SERVER["REQUEST_METHOD"] == "POST" && isset($_POST['test_id'])) {
    $test_id = $_POST['test_id'];

    // Prepare and execute DELETE query
    $stmt = $conn->prepare("DELETE FROM test_results WHERE id = ?");
    $stmt->bind_param("i", $test_id);
    
    if ($stmt->execute()) {
        echo json_encode(["success" => true, "message" => "Test result deleted successfully."]);
    } else {
        echo json_encode(["success" => false, "message" => "Failed to delete test result."]);
    }

    $stmt->close();
    $conn->close();
} else {
    echo json_encode(["success" => false, "message" => "Invalid request."]);
}
?>
