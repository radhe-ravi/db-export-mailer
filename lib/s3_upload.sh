#!/bin/bash
upload_and_presign() {
  local ZIP_PATH="$1"
  local ZIP_NAME="$2"

  aws s3 cp "$ZIP_PATH" "s3://${BUCKET_NAME}/${FOLDER}/${ZIP_NAME}" --region "$S3_REGION" --acl bucket-owner-full-control
  aws s3 presign "s3://${BUCKET_NAME}/${FOLDER}/${ZIP_NAME}" --expires-in 86400 --region "$S3_REGION"
}