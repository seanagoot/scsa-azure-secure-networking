#!/bin/bash

RESOURCE_GROUP="rg-scsa-compute-krc"
PRIVATE_ENDPOINT="pe-scsa-storage-blob"
DNS_ZONE="privatelink.blob.core.windows.net"
STORAGE_ACCOUNT="stscsadata01"

echo "=== Private Endpoint ==="

NIC_ID=$(az network private-endpoint show \
  --name "$PRIVATE_ENDPOINT" \
  --resource-group "$RESOURCE_GROUP" \
  --query "networkInterfaces[0].id" \
  --output tsv)

PRIVATE_IP=$(az network nic show \
  --ids "$NIC_ID" \
  --query "ipConfigurations[0].privateIPAddress" \
  --output tsv)

PE_STATE=$(az network private-endpoint show \
  --name "$PRIVATE_ENDPOINT" \
  --resource-group "$RESOURCE_GROUP" \
  --query "privateLinkServiceConnections[0].privateLinkServiceConnectionState.status" \
  --output tsv)

printf "%-24s %-12s %-15s\n" "PrivateEndpoint" "State" "PrivateIP"
printf "%-24s %-12s %-15s\n" "----------------------" "----------" "-------------"
printf "%-24s %-12s %-15s\n" "$PRIVATE_ENDPOINT" "$PE_STATE" "$PRIVATE_IP"

echo
echo "=== Private DNS ==="

DNS_IP=$(az network private-dns record-set a show \
  --resource-group "$RESOURCE_GROUP" \
  --zone-name "$DNS_ZONE" \
  --name "$STORAGE_ACCOUNT" \
  --query "aRecords[0].ipv4Address" \
  --output tsv)

printf "%-22s %-15s\n" "DNSRecord" "PrivateIP"
printf "%-22s %-15s\n" "--------------------" "-------------"
printf "%-22s %-15s\n" "$STORAGE_ACCOUNT" "$DNS_IP"
