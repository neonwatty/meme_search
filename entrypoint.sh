#!/bin/bash

# Check if database is empty, if so, copy the init files
if [ -z "$(ls -A /home/data/dbs)" ]; then
	cp -r /home/init/* /home/data/dbs
fi

# Start the streamlit app
streamlit run /home/meme_search/app.py --server.port=8501 --server.address=0.0.0.0
