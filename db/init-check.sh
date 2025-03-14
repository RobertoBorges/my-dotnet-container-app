#!/bin/bash

echo "Cleaning up any existing containers and volumes..."
docker-compose down -v

echo "Starting database container..."
docker-compose up -d db

echo "Waiting for MySQL to initialize and run init script (this may take a minute)..."
max_retries=30
counter=0

while ! docker-compose exec -T db mysql -uroot -pmypassword -e "USE mydatabase; SHOW TABLES;" 2>/dev/null | grep -q "users"; do
    counter=$((counter+1))
    if [ $counter -ge $max_retries ]; then
        echo "Failed: Database initialization did not complete properly after $max_retries attempts."
        echo "Checking container logs for errors:"
        docker-compose logs db
        exit 1
    fi
    echo "Database initialization not complete yet... waiting 5 seconds (attempt $counter/$max_retries)"
    sleep 5
done

echo "Success! Database initialized with tables:"
docker-compose exec db mysql -uroot -pmypassword -e "USE mydatabase; SHOW TABLES;"
echo "Sample data:"
docker-compose exec db mysql -uroot -pmypassword -e "USE mydatabase; SELECT * FROM users LIMIT 3;"

echo "Starting application container..."
docker-compose up -d app

echo "Complete system is now running!"
