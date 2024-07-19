import os
import sqlite3
import faiss
from meme_search.utilities import model
from meme_search.utilities.text_extraction import extract_text_from_imgs
from meme_search.utilities.chunks import create_all_img_chunks


def add_to_chunk_db(img_chunks: list, sqlite_db_path: str) -> None:
    # Create a lookup table for chunks
    conn = sqlite3.connect(sqlite_db_path)
    cursor = conn.cursor()

    # Create the table
    cursor.execute("""
        CREATE TABLE IF NOT EXISTS chunks_reverse_lookup (
            img_path TEXT,
            chunk TEXT
        );
    """)

    # Insert data into the table
    for chunk_index, entry in enumerate(img_chunks):
        img_path = entry["img_path"]
        chunk = entry["chunk"]
        cursor.execute(
            "INSERT INTO chunks_reverse_lookup (img_path, chunk) VALUES (?, ?)",
            (img_path, chunk),
        )

    conn.commit()
    conn.close()


def add_to_vector_db(chunks: list, vector_db_path: str) -> None:
    # embed inputs
    embeddings = model.encode(chunks)

    # dump all_embeddings to faiss index
    if os.path.exists(vector_db_path):
        index = faiss.read_index(vector_db_path)
    else:
        index = faiss.IndexFlatL2(embeddings.shape[1])

    index.add(embeddings)
    faiss.write_index(index, vector_db_path)


def add_to_dbs(img_chunks: list, sqlite_db_path: str, vector_db_path: str) -> None:
    try:
        print("STARTING: add_to_dbs")

        # add to db for img_chunks
        add_to_chunk_db(img_chunks, sqlite_db_path)

        # create vector embedding db for chunks
        chunks = [v["chunk"] for v in img_chunks]
        add_to_vector_db(chunks, vector_db_path)
        print("SUCCESS: add_to_dbs succeeded")
    except Exception as e:
        print(f"FAILURE: add_to_dbs failed with exception {e}")


def add(new_imgs_to_be_indexed: list, sqlite_db_path: str, vector_db_path: str) -> None:
    moondream_answers = extract_text_from_imgs(new_imgs_to_be_indexed)
    img_chunks = create_all_img_chunks(new_imgs_to_be_indexed, moondream_answers)
    add_to_dbs(img_chunks, sqlite_db_path, vector_db_path)
