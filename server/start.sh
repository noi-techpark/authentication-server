#!/bin/bash

set -euo pipefail

docker-compose pull
docker-compose up --force-recreate -d
