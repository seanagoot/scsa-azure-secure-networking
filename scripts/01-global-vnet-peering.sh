#!/bin/bash

SEA_RG="rg-scsa-prod"
SEA_VNET="vnet-scsa-prod"

KRC_RG="rg-scsa-compute-krc"
KRC_VNET="vnet-scsa-compute-krc"

VNET_SEA_ID=$(az network vnet show \
  --resource-group "$SEA_RG" \
  --name "$SEA_VNET" \
  --query id \
  --output tsv)

VNET_KRC_ID=$(az network vnet show \
  --resource-group "$KRC_RG" \
  --name "$KRC_VNET" \
  --query id \
  --output tsv)

az network vnet peering create \
  --name peer-sea-to-krc \
  --resource-group "$SEA_RG" \
  --vnet-name "$SEA_VNET" \
  --remote-vnet "$VNET_KRC_ID" \
  --allow-vnet-access

az network vnet peering create \
  --name peer-krc-to-sea \
  --resource-group "$KRC_RG" \
  --vnet-name "$KRC_VNET" \
  --remote-vnet "$VNET_SEA_ID" \
  --allow-vnet-access
