# 1. Use an official slim Python image
FROM python:3.11-slim

# 2. Set a working directory
WORKDIR /app

# 3. Copy only requirements first (leverages Docker cache)
COPY requirements.txt .

# 4. Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# 5. Copy the rest of the application code
COPY . .

# 6. Expose no ports (bot uses outbound only)

# 7. Define entrypoint:  
#    - if config/secrets.py doesn't exist, generate it from ENV
#    - then launch the bot
ENTRYPOINT ["sh","-c","\
  if [ ! -f config/secrets.py ]; then \
    echo \"TOKEN = \\\"${TOKEN}\\\"\" > config/secrets.py; \
  fi && \
  python main.py \
"]
