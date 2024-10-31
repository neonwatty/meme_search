import os

cwd = os.getcwd()
base_test_dir = os.path.dirname(os.path.abspath(__file__))

CONTAINER_NAME = "meme_search"
STREAMLIT_APP_FILE = "meme_search/app.py"
