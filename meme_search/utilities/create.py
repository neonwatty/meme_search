from meme_search.utilities.status import get_input_directory_status
from meme_search.utilities.remove import remove_old_imgs
from meme_search.utilities.add import index_new_imgs


def process() -> bool:
    old_imgs_to_be_removed, new_imgs_to_be_indexed = get_input_directory_status()
    if len(old_imgs_to_be_removed) == 0 and len(new_imgs_to_be_indexed) == 0:
        return False
    print(f"old_imgs_to_be_removed --> {old_imgs_to_be_removed}")
    print(f"new_imgs_to_be_indexed --> {new_imgs_to_be_indexed}")

    if len(old_imgs_to_be_removed) > 0:
        remove_old_imgs(old_imgs_to_be_removed)
    if len(new_imgs_to_be_indexed):
        index_new_imgs(new_imgs_to_be_indexed)
    return True


if __name__ == "__main__":
    process()
