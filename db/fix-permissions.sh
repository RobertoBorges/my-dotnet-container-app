#!/bin/bash

# Ensure init.sql has proper permissions
chmod 644 ./db/init.sql

# Restart the containers with a clean state
echo "Stopping containers and removing volumes..."
docker-compose down -v

echo "Starting containers..."
docker-compose up -d

echo "Waiting for database to initialize (30 seconds)..."
sleep 30

echo "Checking database tables:"
docker-compose exec db mysql -uroot -pmypassword -e "USE mydatabase; SHOW TABLES;"
