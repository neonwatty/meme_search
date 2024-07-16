import sqlite3
import faiss
from meme_search.utilities import model
from meme_search.utilities.imgs import collect_img_paths
from meme_search.utilities.text_extraction import extract_text_from_imgs
from meme_search.utilities.chunks import create_all_img_chunks
from meme_search.utilities import vector_db_path, sqlite_db_path


def create_chunk_db(img_chunks: list, db_filepath: str) -> None:
    # Create a lookup table for chunks
    conn = sqlite3.connect(db_filepath)
    cursor = conn.cursor()

    # Create the table  - delete old table if it exists
    cursor.execute("DROP TABLE IF EXISTS chunks_reverse_lookup")

    # Create the table - alias rowid as chunk_index
    cursor.execute("""
        CREATE TABLE IF NOT EXISTS chunks_reverse_lookup (
            chunk_index INTEGER PRIMARY KEY,
            img_path TEXT,
            chunk TEXT
        );
    """)

    # Insert data into the table
    for chunk_index, entry in enumerate(img_chunks):
        img_path = entry["img_path"]
        chunk = entry["chunk"]
        cursor.execute(
            "INSERT INTO chunks_reverse_lookup (chunk_index, img_path, chunk) VALUES (?, ?, ?)",
            (chunk_index, img_path, chunk),
        )

    conn.commit()
    conn.close()


def create_vector_db(chunks: list, db_file_path: str) -> None:
    # embed inputs
    embeddings = model.encode(chunks)

    # dump all_embeddings to faiss index
    index = faiss.IndexFlatL2(embeddings.shape[1])
    index.add(embeddings)

    # write index to disk
    faiss.write_index(index, db_file_path)


def complete_create_dbs(img_chunks: list, vector_db_path: str, sqlite_db_path: str) -> None:
    try:
        print("STARTING: complete_create_dbs")

        # create db for img_chunks
        create_chunk_db(img_chunks, sqlite_db_path)

        # create vector embedding db for chunks
        chunks = [v["chunk"] for v in img_chunks]
        create_vector_db(chunks, vector_db_path)
        print("SUCCESS: complete_create_dbs succeeded")
    except Exception as e:
        print(f"FAILURE: complete_create_dbs failed with exception {e}")


def process():
    all_img_paths = collect_img_paths()
    moondream_answers = extract_text_from_imgs(all_img_paths)
    img_chunks = create_all_img_chunks(all_img_paths, moondream_answers)
    complete_create_dbs(img_chunks, vector_db_path, sqlite_db_path)


if __name__ == "__main__":
    process()
