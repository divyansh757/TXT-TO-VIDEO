# Base image
FROM python:3.9-slim

# Set working directory
WORKDIR /app

# Copy requirements.txt
COPY requirements.txt .

# Update and install dependencies safely
RUN apt-get update --fix-missing && \
    apt-get install -y --no-install-recommends \
        gcc \
        libffi-dev \
        musl-dev \
        ffmpeg \
        aria2 \
        python3-pip && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy all project files
COPY . .

# Run your bot or app (replace main.py with your actual file)
CMD ["python3", "vars.py"]
