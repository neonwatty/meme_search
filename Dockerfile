FROM python:3.10-slim

WORKDIR /home

ENV PYTHONPATH=.

COPY requirements.txt /home/requirements.txt
COPY meme_search /home/meme_search

RUN pip3 install -r /home/requirements.txt

EXPOSE 8501

HEALTHCHECK CMD curl --fail http://localhost:8501/_stcore/health

ENTRYPOINT ["streamlit", "run", "/home/meme_search/app.py", "--server.port=8501", "--server.address=0.0.0.0"]