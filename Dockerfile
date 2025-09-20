FROM python:3.11-slim

# Install curl + tini for process management
RUN apt-get update && apt-get install -y curl tini \
    && rm -rf /var/lib/apt/lists/*

# Install sshx
RUN curl -s https://sshx.io/get | sh

WORKDIR /app

# Copy python app
COPY app.py /app/

# Install flask
RUN pip install flask

EXPOSE 80

ENTRYPOINT ["/usr/bin/tini", "--"]

# Start Flask + sshx
CMD python /app/app.py & sshx
