import os
import ftplib
import requests
import json

# FTP Credentials
FTP_HOST = "kthcreation.com"
FTP_USER = "TzeHong123@kthcreation.com"
FTP_PASS = "kwXoN+Ab986#"
REMOTE_PATH = "/"  # Upload folder

# PHP API Endpoints
GET_LATEST_TEST_RESULT_URL = "https://kthcreation.com/robot_framework_automation/php/get_latest_test_result.php"
UPDATE_TEST_RESULT_URL = "https://kthcreation.com/robot_framework_automation/php/update_test_result.php"

# Local test result files
LOCAL_LOG_FILE = "results/log.html"
LOCAL_REPORT_FILE = "results/report.html"
SCREENSHOT_DIR = "results/"  # Directory where screenshots are saved

# Step 1: Get the latest test result ID
response = requests.get(GET_LATEST_TEST_RESULT_URL)

if response.status_code == 200:
    result = response.json()
    if result.get("success"):
        test_id = str(result["id"])
        print(f"✅ Latest test ID retrieved: {test_id}")
    else:
        print("❌ No test result found in the database.")
        exit(1)
else:
    print(f"❌ Failed to fetch latest test result. Status Code: {response.status_code}")
    exit(1)

# Step 2: Rename the local log and report files
renamed_files = {
    "log": f"log_{test_id}.html",
    "report": f"report_{test_id}.html"
}

# Step 3: Upload log and report files via FTP
try:
    ftp = ftplib.FTP(FTP_HOST, FTP_USER, FTP_PASS)
    ftp.cwd(REMOTE_PATH)

    # Upload log and report files
    for file_type, new_name in renamed_files.items():
        local_path = LOCAL_LOG_FILE if file_type == "log" else LOCAL_REPORT_FILE

        if not os.path.exists(local_path):
            print(f"❌ ERROR: File not found: {local_path}")
            continue

        with open(local_path, "rb") as file:
            ftp.storbinary(f"STOR {new_name}", file)

        print(f"✅ Uploaded {local_path} as {new_name}")

    # Step 4: Upload all screenshots
    screenshots = [f for f in os.listdir(SCREENSHOT_DIR) if f.endswith(".png")]

    if not screenshots:
        print("⚠️ No screenshots found to upload.")

    for screenshot in screenshots:
        screenshot_path = os.path.join(SCREENSHOT_DIR, screenshot)

        with open(screenshot_path, "rb") as file:
            ftp.storbinary(f"STOR {screenshot}", file)


    ftp.quit()
except Exception as e:
    print(f"❌ FTP Upload Error: {e}")
    exit(1)

# Step 5: Update database with new file names
update_data = {
    "id": test_id,
    "log_file": renamed_files["log"],
    "report_file": renamed_files["report"]
}

response = requests.post(UPDATE_TEST_RESULT_URL, json=update_data)

if response.status_code == 200:
    result = response.json()
    if result.get("success"):
        print("✅ Database updated successfully with log and report file names!")
    else:
        print(f"❌ Error updating database: {result.get('error')}")
else:
    print(f"❌ Failed to communicate with the PHP API. Status Code: {response.status_code}")
