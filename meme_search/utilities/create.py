from meme_search.utilities.status import get_input_directory_status
from meme_search.utilities.remove import remove
from meme_search.utilities.add import add
from meme_search.utilities import img_dir, sqlite_db_path, vector_db_path


def process() -> bool:
    old_imgs_to_be_removed, new_imgs_to_be_indexed = get_input_directory_status(img_dir, sqlite_db_path)
    if len(old_imgs_to_be_removed) == 0 and len(new_imgs_to_be_indexed) == 0:
        return False
    if len(old_imgs_to_be_removed) > 0:
        remove(old_imgs_to_be_removed, sqlite_db_path, vector_db_path)
    if len(new_imgs_to_be_indexed):
        add(new_imgs_to_be_indexed, sqlite_db_path, vector_db_path)
    return True


if __name__ == "__main__":
    process()
