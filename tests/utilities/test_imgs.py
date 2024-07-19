import os
from meme_search import meme_search_root_dir
from meme_search.utilities.imgs import collect_img_paths, allowable_extensions


def list_files_in_directory(directory_path):
    try:
        files = [f for f in os.listdir(directory_path) if (os.path.isfile(os.path.join(directory_path, f)) and f.split(".")[-1] in allowable_extensions)]
        return files
    except OSError as error:
        print(f"Error accessing directory '{directory_path}': {error}")
        return []


def test_collect_img_paths():
    img_data_path = meme_search_root_dir + "/data/input"
    actual_files = list_files_in_directory(img_data_path)
    output_files = collect_img_paths(img_data_path)
    output_files = [v.split("/")[-1] for v in output_files]
    assert len(set(actual_files) - set(output_files)) == 0
