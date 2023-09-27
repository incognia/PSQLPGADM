#!/usr/bin/env bash
docker compose down -v
docker rmi cdmx.fondeso/postgres:0.0.1-bookworm-slim
yes | docker system prune