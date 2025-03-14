FROM mysql:8.0

# Copy init.sql with proper permissions
COPY init.sql /docker-entrypoint-initdb.d/init.sql
RUN chmod 644 /docker-entrypoint-initdb.d/init.sql

# Set default MySQL configuration
ENV MYSQL_DATABASE=mydatabase
ENV MYSQL_ROOT_PASSWORD=mypassword

# Add a health check
HEALTHCHECK --interval=5s --timeout=5s --retries=20 --start-period=10s \
  CMD mysqladmin ping -h localhost -u root -p$MYSQL_ROOT_PASSWORD || exit 1
