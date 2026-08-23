#!/bin/bash

RESOURCE_GROUP="rg-scsa-compute-krc"
LOCATION="koreacentral"
VNET_NAME="vnet-scsa-compute-krc"
SUBNET_NAME="snet-compute"
ROUTE_TABLE="rt-scsa-compute-krc"

az network route-table create \
  --resource-group "$RESOURCE_GROUP" \
  --name "$ROUTE_TABLE" \
  --location "$LOCATION"

az network route-table route create \
  --resource-group "$RESOURCE_GROUP" \
  --route-table-name "$ROUTE_TABLE" \
  --name route-block-unused-network \
  --address-prefix 10.30.0.0/16 \
  --next-hop-type None

az network vnet subnet update \
  --resource-group "$RESOURCE_GROUP" \
  --vnet-name "$VNET_NAME" \
  --name "$SUBNET_NAME" \
  --route-table "$ROUTE_TABLE"
