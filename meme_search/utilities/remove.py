import sqlite3
import faiss
import numpy as np
from meme_search.utilities import vector_db_path, sqlite_db_path


def collect_removal_rowids(old_imgs_to_be_removed: list) -> list:
    try:
        if len(old_imgs_to_be_removed) > 0:
            conn = sqlite3.connect(sqlite_db_path)
            cursor = conn.cursor()
            query = f"""SELECT rowid FROM chunks_reverse_lookup WHERE img_path IN ({','.join(['"'+v+'"' for v in old_imgs_to_be_removed])})"""
            cursor.execute(query)
            rows = cursor.fetchall()
            rowids = [v[0] for v in rows]
            conn.close()
            return rowids
        else:
            return []
    except Exception as e:
        raise ValueError(f"FAILURE: collect_removal_rowids failed with exception {e}")


def delete_removal_rowids_from_reverse_lookup(rowids: list) -> None:
    try:
        if len(rowids) > 0:
            conn = sqlite3.connect(sqlite_db_path)
            cursor = conn.cursor()
            if len(rowids) == 1:
                query = f"""DELETE FROM chunks_reverse_lookup WHERE rowid IN ({str(rowids[0])})"""
            else:
                query = f"""DELETE FROM chunks_reverse_lookup WHERE rowid IN ({','.join([str(v) for v in rowids])})"""
            cursor.execute(query)
            conn.commit()
            conn.close()

            conn = sqlite3.connect(sqlite_db_path)
            cursor = conn.cursor()
            cursor.execute("VACUUM;")
            conn.commit()
            conn.close()
    except Exception as e:
        raise ValueError(f"FAILURE: delete_removal_rowids failed with exception {e}")


def delete_removal_rowids_from_vector_db(rowids: list) -> None:
    try:
        if len(rowids) > 0:
            index = faiss.read_index(vector_db_path)
            remove_set = np.array(rowids, dtype=np.int64)
            index.remove_ids(remove_set)
            faiss.write_index(index, vector_db_path)
    except Exception as e:
        raise ValueError(f"FAILURE: delete_removal_rowids failed with exception {e}")


def remove_old_imgs(old_imgs_to_be_removed: list) -> None:
    row_ids = collect_removal_rowids(old_imgs_to_be_removed)
    delete_removal_rowids_from_reverse_lookup(row_ids)
    delete_removal_rowids_from_vector_db(row_ids)
