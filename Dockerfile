# Build stage
FROM python:3.10-slim AS builder

RUN apt-get update && apt-get install -y \
    build-essential \
    curl \
    software-properties-common \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /home

COPY requirements.txt .

RUN pip3 install --no-cache-dir -r requirements.txt

# Runtime stage
FROM python:3.10-slim

ENV PYTHONPATH=.

WORKDIR /home

COPY --from=builder /usr/local/lib/python3.10/site-packages /usr/local/lib/python3.10/site-packages
COPY --from=builder /usr/local/bin /usr/local/bin
COPY meme_search /home/meme_search
COPY .streamlit /home/.streamlit

EXPOSE 8501

HEALTHCHECK CMD curl --fail http://localhost:8501/_stcore/health || exit 1

ENTRYPOINT ["streamlit", "run", "/home/meme_search/app.py", "--server.port=8501", "--server.address=0.0.0.0"]
