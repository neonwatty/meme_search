import sqlite3
from meme_search.utilities.imgs import collect_img_paths


def get_current_indexed_img_names(sqlite_db_path: str):
    try:
        print("STARTING: collecting currently indexed names")
        conn = sqlite3.connect(sqlite_db_path)
        cursor = conn.cursor()
        query = f"SELECT DISTINCT(img_path) FROM chunks_reverse_lookup"
        cursor.execute(query)
        rows = cursor.fetchall()
        rows = [v[0] for v in rows]
        conn.close()
        print("SUCCESS: get_current_indexed_img_names ran successfully")
        return rows
    except Exception as e:
        raise ValueError(f"FAILURE: get_current_indexed_img_names failed with exception {e}")


def get_input_directory_status(img_dir: str, sqlite_db_path: str):
    all_img_paths = collect_img_paths(img_dir)
    all_img_paths_stubs = ["./" + "/".join(v.split("/")[-3:]).strip() for v in all_img_paths]
    current_indexed_names = get_current_indexed_img_names(sqlite_db_path)

    old_imgs_to_be_removed = list(set(current_indexed_names) - set(all_img_paths_stubs))
    new_imgs_to_be_indexed = list(set(all_img_paths_stubs) - set(current_indexed_names))
    return old_imgs_to_be_removed, new_imgs_to_be_indexed
