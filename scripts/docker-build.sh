#!/bin/bash

set -e

echo "Building backend image..."

docker build -t muchtodo-backend:v1 .

echo "Build complete."