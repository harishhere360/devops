# Use an official Python runtime as a parent image
FROM python:3.11-slim

# Set environment variables
ENV USERNAME=webuser
ENV HOME=/home/$USERNAME
ENV CERTS_DIR=$HOME/certs
ENV WORKDIR=$HOME/server

# Create a non-root user and directories for the certificates and server files
RUN useradd -m -d $HOME $USERNAME && \
    mkdir -p $CERTS_DIR && \
    mkdir -p $WORKDIR && \
    chown -R $USERNAME:$USERNAME $HOME

# Install required packages
RUN apt-get update && \
    apt-get install -y --no-install-recommends openssl && \
    rm -rf /var/lib/apt/lists/*

# Switch to the non-root user
USER $USERNAME

# Generate a self-signed SSL certificate
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout $CERTS_DIR/server.key \
    -out $CERTS_DIR/server.crt \
    -subj "/C=US/ST=State/L=City/O=Organization/OU=Department/CN=localhost"

# Set the working directory
WORKDIR $WORKDIR

# Copy the server script into the container
COPY server.py .

# Expose port 4443
EXPOSE 4443

# Run the Python server
CMD ["python", "server.py"]
