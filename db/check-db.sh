#!/bin/bash

echo "Waiting for MySQL to be ready..."

# Try to connect to MySQL with retries
max_retries=30
counter=0
while ! docker-compose exec -T db mysql -uroot -pmypassword -e "SELECT 1" >/dev/null 2>&1; do
    counter=$((counter+1))
    if [ $counter -ge $max_retries ]; then
        echo "Failed to connect to MySQL after $max_retries attempts."
        exit 1
    fi
    echo "MySQL not ready yet... waiting 2 seconds (attempt $counter/$max_retries)"
    sleep 2
done

echo "MySQL is now available!"
echo "Checking MySQL tables in mydatabase:"
docker-compose exec db mysql -uroot -pmypassword -e "USE mydatabase; SHOW TABLES;"

echo "Checking sample data from users table:"
docker-compose exec db mysql -uroot -pmypassword -e "USE mydatabase; SELECT * FROM users LIMIT 3;"

echo "Checking sample data from states table:" 
docker-compose exec db mysql -uroot -pmypassword -e "USE mydatabase; SELECT * FROM states LIMIT 5;"

echo "Checking sample data from addresses table:"
docker-compose exec db mysql -uroot -pmypassword -e "USE mydatabase; SELECT * FROM addresses LIMIT 3;"
