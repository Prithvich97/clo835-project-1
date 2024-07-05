# Stage 1: Build the Python applicationdocker build -t yourusername/python-app .
FROM python:3.9-slim AS builder

# Set the working directory inside the container
WORKDIR /app

# Copy the requirements file and install dependencies
COPY requirements.txt .
RUN pip install -r requirements.txt

# Copy the rest of the application source code
COPY . .

# Stage 2: Create the final lightweight image
FROM python:3.9-slim

# Set the working directory inside the container
WORKDIR /app


COPY --from=builder /usr/local/lib/python3.9/site-packages /usr/local/lib/python3.9/site-packages

# Copy the built application from the previous stage
COPY --from=builder /app .

# Expose port 3000 to allow external access
EXPOSE 3000

# Specify the command to run your application
CMD ["python", "app.py"]
