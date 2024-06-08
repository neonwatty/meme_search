import os
from sentence_transformers import SentenceTransformer

model = SentenceTransformer("sentence-transformers/all-MiniLM-L6-v2")
utilities_base_dir = os.path.dirname(os.path.abspath(__file__))
meme_search_dir = os.path.dirname(utilities_base_dir)
meme_search_root_dir = os.path.dirname(meme_search_dir)

vector_db_path = meme_search_root_dir + "/data/dbs/memes.faiss"
sqlite_db_path = meme_search_root_dir + "/data/dbs/memes.db"
