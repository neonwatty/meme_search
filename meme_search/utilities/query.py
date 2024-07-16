import faiss
import sqlite3
import numpy as np
from typing import Tuple
import argparse
from meme_search.utilities import model
from meme_search.utilities import vector_db_path, sqlite_db_path


def query_vector_db(query: str, db_file_path: str, k: int = 10) -> Tuple[list, list]:
    # connect to db
    faiss_index = faiss.read_index(db_file_path)

    # test
    encoded_query = np.expand_dims(model.encode(query), axis=0)

    # query db
    distances, indices = faiss_index.search(encoded_query, k)
    distances = distances.tolist()[0]
    indices = indices.tolist()[0]
    return distances, indices


def query_sqlite_db(indices: list, db_filepath: str) -> list:
    conn = sqlite3.connect(db_filepath)
    cursor = conn.cursor()
    query = f"SELECT * FROM chunks_reverse_lookup WHERE chunk_index IN {tuple(indices)}"
    cursor.execute(query)
    rows = cursor.fetchall()
    rows = [{"index": row[0], "img_path": row[1], "chunk": row[2]} for row in rows]
    rows = sorted(rows, key=lambda x: indices.index(x["index"]))  # re-sort rows according to input indices
    for row in rows:
        query = f"SELECT * FROM chunks_reverse_lookup WHERE chunk_index=(SELECT MIN(chunk_index) FROM chunks_reverse_lookup WHERE img_path='{row['img_path']}')"
        cursor.execute(query)
        full_description_row = cursor.fetchall()
        row["full_description"] = full_description_row[0][2]
    conn.close()
    return rows


def complete_query(query: str, vector_db_path: str, sqlite_db_path: str, k: int = 10) -> list:
    try:
        print("STARTING: complete_query")

        # query vector_db, first converting input query to embedding
        distances, indices = query_vector_db(query, vector_db_path, k=k)

        # use indices to query sqlite db containing chunk data
        img_chunks = query_sqlite_db(indices, sqlite_db_path)  # bump up indices by 1 since sqlite row index starts at 1 not 0

        # map indices back to correct image in img_chunks
        imgs_seen = []
        unique_img_entries = []
        for ind, entry in enumerate(img_chunks):
            if entry["img_path"] in imgs_seen:
                continue
            else:
                entry["distance"] = round(distances[ind], 2)
                unique_img_entries.append(entry)
                imgs_seen.append(entry["img_path"])
        print("SUCCESS: complete_query succeeded")
        return unique_img_entries
    except Exception as e:
        print(f"FAILURE: complete_query failed with exception {e}")
        raise e


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("--query", dest="query", type=str, help="Add query")
    args = parser.parse_args()
    query = args.query

    print(query)
    results = complete_query(query, vector_db_path, sqlite_db_path)
    print(results)
