# Meme Search app, walkthrough, and demo

Index your memes by their content and text, making them easily retrievable for your meme warfare pleasures.

This repository contains code, a walkthrough notebook (`meme_search_walkthrough.ipynb`), and streamlit demo app for indexing, searching, and easily retrieving your memes based on semantic search of their content and text.

All processing - from image-to-text extraction, to vector embedding, to search - are performed locally.

This process uses the following open source components:

- [moondream](https://github.com/vikhyat/moondream): a tiny, kickass vision llm used for image captioning / extracting image text
- [all-MiniLM-L6-v2](https://huggingface.co/sentence-transformers/all-MiniLM-L6-v2): a very popular text embedding model
- [faiss](https://github.com/facebookresearch/faiss): a fast and efficient vector db
- [sqlite](https://sqlite.org/): the greatest database of all time, used for data indexing
- [streamlit](https://github.com/streamlit/streamlit): for serving up the app


## Installation instructions

To create a handy tool for your own memes pull the repo and install the requirements file

```python
pip install -r requirements.txt
```

Note that the particular pinned requirements here are necessary to avoid a current nasty segmentation fault involving `sentence-transformers` [as of 6/5/2024](https://github.com/UKPLab/sentence-transformers/issues/1319).


##  Index your own memes

Place any images / memes you would like indexed for the search app in this repo's subdirectory

`data/input/`

You can clear out the default test images in this location first, or leave them.

Next - at your terminal - paste the following command

```python
python meme_search/utilities/create.py
```

You will see printouts at the terminal indicating success of the 3 main stages for making your memes searchable.  These steps - outlined in the repo notebook `meme_search_walkthrough.ipynb` - are

1.  Extracting a text based description of your images using moondream  - this can take sometime depending on your hardware setup / number of images.  The first extraction - which is performed in batches of 3 images at a time - takes the longest, with subsequent batches computed considerably more quickly.
2.  Embedding and storing text extractions in a vector database
3.  Storing chunk information in a sqlite database


## starting the streamlit server

After indexing your memes you can then start the streamlit app, allowing you to semantically search for and retrieve your memes

```python
python -m streamlit run meme_search/app.py
```

Note: you can drag and drop any recovered meme directly from the streamlit app to any messager app of your choice.