import os
import mimetypes
import argparse
import logging
from azure.storage.blob import BlobServiceClient, ContentSettings
from dotenv import load_dotenv

# Resolve paths relative to script location
BASE_DIR = os.path.abspath(os.path.join(os.path.dirname(__file__), ".."))
CONTENT_DIR = os.path.join(BASE_DIR, "content", "content")
ENV_PATH = os.path.join(BASE_DIR, ".env")
LOG_PATH = os.path.join(BASE_DIR, "upload.log")

# Logging
logging.basicConfig(
    filename=LOG_PATH,
    level=logging.INFO,
    format="%(asctime)s - %(levelname)s - %(message)s"
)

# CLI arguments
parser = argparse.ArgumentParser(description="Upload images to Azure Blob storage.")
parser.add_argument("--dry-run", action="store_true", help="Show what would be uploaded without uploading.")
args = parser.parse_args()

# Load .env
load_dotenv(dotenv_path=ENV_PATH)
connection_string = os.getenv("AZURE_STORAGE_CONNECTION_STRING")
if not connection_string:
    raise Exception("AZURE_STORAGE_CONNECTION_STRING not found in .env")

container_name = "public-assets"
blob_service_client = BlobServiceClient.from_connection_string(connection_string)
container_client = blob_service_client.get_container_client(container_name)

# Loop through content and upload all files
for root, dirs, files in os.walk(CONTENT_DIR):
    for file in files:
        local_path = os.path.join(root, file)

        # calculate relative blob path inside 'content/' prefix
        relative_path = os.path.relpath(local_path, CONTENT_DIR).replace("\\","/")
        blob_path = f"content/{relative_path}"

        mime_type = (mimetypes.guess_type(file)[0] or "application/octet-stream").lower()

        log_msg = f"{'DRY RUN - ' if args.dry_run else ''}Uploading: {blob_path}"
        print(log_msg)
        logging.info(log_msg)

        if args.dry_run:
            continue

        with open(local_path, "rb") as data:
            container_client.upload_blob(
                name=blob_path,
                data=data,
                overwrite=True,
                content_settings=ContentSettings(content_type=mime_type)
            )

logging.info("Upload process complete.")
print("Upload complete.")