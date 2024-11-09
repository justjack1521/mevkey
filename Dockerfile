# Start from the official Keycloak image
FROM quay.io/keycloak/keycloak:latest

# Set environment variables for Keycloak configuration
# Set the database to be used (e.g., 'dev-file' for testing, 'postgres', 'mysql', etc.)
ENV KC_DB dev-file
# Set the hostname (customize this as needed)
ENV KC_HOSTNAME localhost

# Copy any custom scripts or configuration files (optional)
# COPY ./custom-configs /opt/keycloak/custom-configs

# Expose the Keycloak port
EXPOSE 8080

# Run Keycloak
ENTRYPOINT ["keycloak", "start-dev"]
