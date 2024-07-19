import os
import shutil
import time
from meme_search.utilities.status import get_input_directory_status
from meme_search.utilities.add import add
from meme_search.utilities.remove import remove
from tests import base_test_dir

utilities_dir = base_test_dir + "/utilities"
default_test_img_dir = utilities_dir + "/test_images/"
alt_test_img_dir = utilities_dir + "/test_images_alternate/"
db_test_dir = utilities_dir + "/test_dbs/"
sqlite_db_path = db_test_dir + "memes.db"
vector_db_path = db_test_dir + "memes.faiss"
test_img_default_location = default_test_img_dir + "test_meme_2.jpg"
test_img_alt_location = alt_test_img_dir + "test_meme_2.jpg"


def test_normalize(subtests):
    with subtests.test(msg="reset image directories"):
        try:
            shutil.move(test_img_alt_location, default_test_img_dir)
        except:
            pass

        time.sleep(2)

        old_imgs_to_be_removed, new_imgs_to_be_indexed = get_input_directory_status(default_test_img_dir, sqlite_db_path)
        if len(old_imgs_to_be_removed) > 0:
            assert remove(old_imgs_to_be_removed, sqlite_db_path, vector_db_path) is None
            
        if len(new_imgs_to_be_indexed) > 0:
            assert add(new_imgs_to_be_indexed, sqlite_db_path, vector_db_path) is None

    with subtests.test(msg="normalize final check"):
        old_imgs_to_be_removed, new_imgs_to_be_indexed = get_input_directory_status(default_test_img_dir, sqlite_db_path)
        assert len(old_imgs_to_be_removed) == 0
        assert len(new_imgs_to_be_indexed) == 0
    

def test_remove(subtests):
    
    with subtests.test(msg="move from default to alt"):
        shutil.move(test_img_default_location, alt_test_img_dir)
        time.sleep(5)
        assert os.path.exists(test_img_alt_location), "FAILURE: image could not be moved from default to alt location"

    with subtests.test(msg="remove old imgs"):
        old_imgs_to_be_removed, new_imgs_to_be_indexed = get_input_directory_status(default_test_img_dir, sqlite_db_path)
        assert len(old_imgs_to_be_removed) > 0
        assert len(new_imgs_to_be_indexed) == 0
        assert remove(old_imgs_to_be_removed, sqlite_db_path, vector_db_path) is None, "FAILURE: removing moving image"
            
    with subtests.test(msg="remove final check"):
        old_imgs_to_be_removed, new_imgs_to_be_indexed = get_input_directory_status(default_test_img_dir, sqlite_db_path)
        assert len(old_imgs_to_be_removed) == 0
        assert len(new_imgs_to_be_indexed) == 0

    
def test_add(subtests):
    with subtests.test(msg="move from alt to default"):
        shutil.move(test_img_alt_location, default_test_img_dir)
        time.sleep(5)
        assert os.path.exists(test_img_default_location), "FAILURE: image could not be moved from alt to default location"

    with subtests.test(msg="add new img"):
        old_imgs_to_be_removed, new_imgs_to_be_indexed = get_input_directory_status(default_test_img_dir, sqlite_db_path)
        assert len(new_imgs_to_be_indexed) > 0
        assert len(old_imgs_to_be_removed) == 0
        assert add(new_imgs_to_be_indexed, sqlite_db_path, vector_db_path) is None, "FAILURE: adding image"
        
    with subtests.test(msg="add final check"):
        old_imgs_to_be_removed, new_imgs_to_be_indexed = get_input_directory_status(default_test_img_dir, sqlite_db_path)
        assert len(old_imgs_to_be_removed) == 0
        assert len(new_imgs_to_be_indexed) == 0