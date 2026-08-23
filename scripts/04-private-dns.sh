#!/bin/bash

RESOURCE_GROUP="rg-scsa-compute-krc"
VNET_NAME="vnet-scsa-compute-krc"
PRIVATE_ENDPOINT="pe-scsa-storage-blob"

DNS_ZONE="privatelink.blob.core.windows.net"
DNS_LINK="link-scsa-compute-krc"
DNS_ZONE_GROUP="dzg-scsa-storage-blob"

# Create Private DNS zone
az network private-dns zone create \
  --resource-group "$RESOURCE_GROUP" \
  --name "$DNS_ZONE"

# Link Private DNS zone to the compute VNet
az network private-dns link vnet create \
  --resource-group "$RESOURCE_GROUP" \
  --zone-name "$DNS_ZONE" \
  --name "$DNS_LINK" \
  --virtual-network "$VNET_NAME" \
  --registration-enabled false

# Associate the Private Endpoint with the Private DNS zone
az network private-endpoint dns-zone-group create \
  --resource-group "$RESOURCE_GROUP" \
  --endpoint-name "$PRIVATE_ENDPOINT" \
  --name "$DNS_ZONE_GROUP" \
  --private-dns-zone "$DNS_ZONE" \
  --zone-name blob
