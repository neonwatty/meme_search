import re


def clean_word(text: str) -> str:
    # clean input text - keeping only lower case letters, numbers, punctuation, and single quote symbols
    return re.sub(" +", " ", re.compile("[^a-z0-9,.!?']").sub(" ", text.lower().strip()))


def chunk_text(text: str) -> list:
    # split and clean input text
    text_split = clean_word(text).split(" ")
    text_split = [v for v in text_split if len(v) > 0]

    # use two pointers to create chunks
    chunk_size = 4
    overlap_size = 2

    # create next chunk by moving right pointer until chunk_size is reached or line_number changes by more than 1 or end of word_sequence is reached
    left_pointer = 0
    right_pointer = chunk_size - 1
    chunks = []

    if right_pointer >= len(text_split):
        chunks = [" ".join(text_split)]
    else:
        while right_pointer < len(text_split):
            # check if chunk_size has been reached
            # create chunk
            chunk = text_split[left_pointer : right_pointer + 1]

            # move left pointer
            left_pointer += chunk_size - overlap_size

            # move right pointer
            right_pointer += chunk_size - overlap_size

            # store chunk
            chunks.append(" ".join(chunk))

        # check if there is final chunk
        if len(text_split[left_pointer:]) > 0:
            last_chunk = text_split[left_pointer:]
            chunks.append(" ".join(last_chunk))

    # insert the full text
    if len(chunks) > 1:
        chunks.insert(0, text.lower())
    return chunks


# loop over each meme's moondream based text descriptor and create a short dict containing its full and chunked text
def create_all_img_chunks(img_paths: list, answers: list) -> list:
    try:
        print("STARTING: create_all_img_chunks")
        img_chunks = []
        for ind, img_path in enumerate(img_paths):
            moondream_meme_text = answers[ind]
            moondream_chunks = chunk_text(moondream_meme_text)
            for chunk in moondream_chunks:
                entry = {}
                entry["img_path"] = img_path
                entry["chunk"] = chunk
                img_chunks.append(entry)
        print("SUCCESS: create_all_img_chunks ran successfully")
        return img_chunks
    except Exception as e:
        print(f"FAILURE: create_all_img_chunks failed with exception {e}")
        raise e
