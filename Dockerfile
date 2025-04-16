FROM python:3.12-slim

# Avoid interactive prompts during builds
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    RASA_TELEMETRY_ENABLED=false

# Set working directory
WORKDIR /app

# Install system dependencies (some required for Rasa & TensorFlow)
RUN apt-get update && apt-get install -y \
    build-essential \
    libpq-dev \
    curl \
    git \
    && rm -rf /var/lib/apt/lists/*

# Copy dependencies
COPY requirements.txt .

# Install Python dependencies
RUN pip install --upgrade pip && pip install --no-cache-dir -r requirements.txt

# Copy the rest of the app
COPY . .

# Expose ports (Rasa API + Action Server)
EXPOSE 5005 5055

# Run Rasa and Custom Actions in parallel
CMD ["sh", "-c", "rasa run --enable-api --cors '*' --port 5005 & rasa run actions --port 5055 && wait"]
