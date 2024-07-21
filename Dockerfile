FROM python:3.10-slim

RUN apt-get update && apt-get install -y \
    build-essential \
    curl \
    software-properties-common \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /home

ENV PYTHONPATH=.

COPY requirements.txt /home/requirements.txt
COPY meme_search /home/meme_search
COPY data/dbs /home/init
COPY .streamlit /home/.streamlit

RUN pip3 install -r /home/requirements.txt

EXPOSE 8501

HEALTHCHECK CMD curl --fail http://localhost:8501/_stcore/health

COPY entrypoint.sh /home/entrypoint.sh
RUN chmod +x /home/entrypoint.sh
ENTRYPOINT ["/home/entrypoint.sh"]