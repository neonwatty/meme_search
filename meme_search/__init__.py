import os

base_dir = os.path.dirname(os.path.abspath(__file__))
meme_search_root_dir = os.path.dirname(base_dir)

vector_db_path = meme_search_root_dir + "/data/dbs/memes.faiss"
sqlite_db_path = meme_search_root_dir + "/data/dbs/memes.db"
