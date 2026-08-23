#!/bin/bash

STORAGE_ACCOUNT="stscsadata01"

echo "=== Private DNS Resolution ==="

nslookup "${STORAGE_ACCOUNT}.blob.core.windows.net"

echo
echo "=== HTTPS Connectivity ==="

curl -I "https://${STORAGE_ACCOUNT}.blob.core.windows.net"
