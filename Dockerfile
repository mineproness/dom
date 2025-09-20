FROM python:3.11-slim

# Install dependencies: curl (for sshx), tini (clean process manager)
RUN apt-get update && apt-get install -y curl tini \
    && rm -rf /var/lib/apt/lists/*

# Install sshx
RUN curl -s https://sshx.io/get | sh

# Set workdir
WORKDIR /app

# Copy app
COPY app.py /app/

# Install Python deps
RUN pip install flask

# Expose ports
EXPOSE 80

# Use tini as entrypoint to manage multiple processes
ENTRYPOINT ["/usr/bin/tini", "--"]

# Start Flask server + sshx (runs in background)
CMD python /app/app.py & sshx
