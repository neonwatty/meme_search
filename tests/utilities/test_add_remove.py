import os
from meme_search.utilities.status import get_input_directory_status
from meme_search.utilities.add import add_to_dbs
from meme_search.utilities.remove import remove_old_imgs
from tests import base_test_dir

utilities_dir = base_test_dir + "/utilities"
test_img_dir = utilities_dir + "/test_images/"
alt_test_img_dir = utilities_dir + "/test_images_alternate/"
db_test_dir = utilities_dir + "/test_dbs/"
sqlite_db_path = db_test_dir + "test.db"
vector_db_path = db_test_dir + "test.faiss"

print(f"base_test_dir --> {base_test_dir}")
print(f"db_test_dir --> {db_test_dir}")
print(f"test_img_dir --> {test_img_dir}")
print(f"old_imgs_to_be_removed --> {old_imgs_to_be_removed}")
print(f"new_imgs_to_be_indexed --> {new_imgs_to_be_indexed}")
print(f"sqlite_db_path --> {sqlite_db_path}")
print(f"vector_db_path --> {vector_db_path}")

def test_init():
    old_imgs_to_be_removed, new_imgs_to_be_indexed = get_input_directory_status(test_img_dir, sqlite_db_path)

    if len(old_imgs_to_be_removed) > 0:
        assert remove_old_imgs(old_imgs_to_be_removed, sqlite_db_path, vector_db_path) is None
        
    if len(new_imgs_to_be_indexed) > 0:
        assert add_to_dbs(old_imgs_to_be_removed, sqlite_db_path, vector_db_path) is None