#!/bin/bash

COMPUTE_RG="rg-scsa-compute-krc"
LOCATION="koreacentral"
VNET_NAME="vnet-scsa-compute-krc"
SUBNET_NAME="snet-compute"

STORAGE_RG="rg-scsa-storage-sea"
STORAGE_ACCOUNT="stscsadata01"

PRIVATE_ENDPOINT="pe-scsa-storage-blob"
CONNECTION_NAME="psc-scsa-storage-blob"

STORAGE_ID=$(az storage account show \
  --resource-group "$STORAGE_RG" \
  --name "$STORAGE_ACCOUNT" \
  --query id \
  --output tsv)

az network private-endpoint create \
  --name "$PRIVATE_ENDPOINT" \
  --resource-group "$COMPUTE_RG" \
  --location "$LOCATION" \
  --vnet-name "$VNET_NAME" \
  --subnet "$SUBNET_NAME" \
  --private-connection-resource-id "$STORAGE_ID" \
  --group-id blob \
  --connection-name "$CONNECTION_NAME"
