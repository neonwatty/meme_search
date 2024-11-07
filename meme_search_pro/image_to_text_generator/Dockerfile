# Use the official Python image
FROM python:3.12-slim

# install uv
RUN pip --timeout=1000 install uv

# Set the working directory
WORKDIR /app

# Copy the requirements file and app code
COPY . ./

# Install the required Python packages
RUN uv pip install --system -r requirements.txt

# Expose the port the app runs on
EXPOSE 8000

# download model
RUN python model_init.py

# Command to run the application
CMD ["python", "app.py"]
