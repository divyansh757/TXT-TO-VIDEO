# Base image
FROM python:3.9-slim

# Set working directory
WORKDIR /app

# Copy requirements.txt first (to leverage Docker cache)
COPY requirements.txt .

# Update & install dependencies safely
RUN apt-get update --fix-missing && \
    apt-get install -y --no-install-recommends \
        gcc \
        libffi-dev \
        libssl-dev \
        ffmpeg \
        aria2 \
        python3-pip && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy all project files
COPY . .

# Default command (change vars.py to your main file)
CMD ["python3", "vars.py"]
