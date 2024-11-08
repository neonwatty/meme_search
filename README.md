<a href="https://colab.research.google.com/github/jermwatt/meme_search/blob/main/meme_search_walkthrough.ipynb" target="_parent"><img src="https://colab.research.google.com/assets/colab-badge.svg" alt="Open In Colab"/></a> <a href="https://www.youtube.com/watch?v=P1k1EGvoJIg" target="_parent"><img src="https://badges.aleen42.com/src/youtube.svg" alt="Youtube"/></a> [![Python application](https://github.com/neonwatty/meme_search/actions/workflows/python-app.yml/badge.svg)](https://github.com/neonwatty/meme_search/actions/workflows/python-app.yml/python-app.yml)

# Meme Search app, walkthrough, and demo

Use AI to index your memes by their content and text, making them easily retrievable for your meme warfare pleasures.

All processing - from image-to-text extraction, to vector embedding, to search - is performed locally.

<p align="center">
<img align="center" src="https://github.com/jermwatt/readme_gifs/blob/main/meme-search-pro-search-example.gif" height="325">
</p>

This repository contains code, a walkthrough notebook (`meme_search_walkthrough.ipynb`), and apps for indexing, searching, and easily retrieving your memes based on semantic search of their content and text.

A table of contents for the remainder of this README:

- [Version overall comparison](#version-overall-comparison)
- [Meme search - standard version](#meme-search---standard-version)

  - [Features](#features---standard-version)
  - [Installation instructions](#installation-instructions---standard-version)
  - [Index your memes](#index-your-memes---standard-version)
  - [Pipeline overview](#pipeline-overview---standard-version)
  - [Running tests](#running-tests---standard-version)

- [Meme search - pro version](#meme-search---pro-version)

  - [Features](#features)
  - [Installation instructions](#installation-instructions---pro-version)
  - [Index your memes](#index-your-memes---pro-version)
  - [Pipeline overview](#pipeline-overview---pro-version)
  - [Running tests](#running-tests---pro-version)

- [Changelog](#changelog)
- [Feature requests and contributing](#feature-requests-and-contributing)

## Version overall comparison

This repo contains two versions of the meme search app. Both versions can be used for core meme search organization and retrieval, with the pro version offering a significantly expanded feature set at the cost of more complex architecture.

1.  **[The standard version](#meme-search---standard-version):** a simple one page app that contains all the base functionality you need. Simple to install and configure.

2.  **[The pro version](#meme-search---pro-version):** a multi-page app with enhanced UI and additional features driven by the community - like description editing, meme tagging, and multi-path indexing. Requires larger memory footprint.

## Meme search - standard version

### Features - standard version

The standard version of meme search is a simple one page app that allows you to index a diretory of memes and recover them via text based search as illustrated below.

<p align="center">
<img align="center" src="https://github.com/jermwatt/readme_gifs/blob/main/meme_search.gif" height="325">
</p>

While not as feature rich as the [pro version of meme search], the standard version provides all the base functionality you need to organize and recover your memes. The standard version is also simpler to install and configure, consisting of a single server / docker container.

### Installation instructions - standard version

To create a handy tool for your own memes pull the repo and install the requirements file

```sh
pip install -r requirements.txt
```

Note that the particular pinned requirements here are necessary to avoid a current nasty segmentation fault involving `sentence-transformers` [as of 6/5/2024](https://github.com/UKPLab/sentence-transformers/issues/1319).

Alternatively you can install all the requirements you need using docker via the compose file found in the repo. The command to install the above requirements and start the server using docker-compose is

```sh
docker compose up
```

After indexing your memes you can then start the server (a streamlit app), allowing you to semantically search for and retrieve your memes

```sh
python -m streamlit run meme_search/app.py
```

To start the app via docker-compose use

```sh
docker compose up
```

Note: you can drag and drop any recovered meme directly from the streamlit app to any messager app of your choice.

### Index your memes - standard version

Place any images / memes you would like indexed for the search app in this repo's subdirectory

```sh
data/input/
```

You can clear out the default test images in this location first, or leave them.

Next, click the "refresh index" button to update your index when images are added or removed from the image directory, affecting only the newly added or removed images.

<p align="center">
<img align="center" src="https://github.com/jermwatt/readme_gifs/blob/main/meme_search_refresh_button.gif" height="200">
</p>

Alternatively - at your terminal - paste the following command

```sh
python meme_search/utilities/create.py
```

or if running the server via docker us

```sh
docker exec meme_search python meme_search/utilities/create.py
```

You will see printouts at the terminal indicating success of the 3 main stages for making your memes searchable. These steps are

1.  **extract**: get text descriptions of each image, including ocr of any text on the image, using the kickass tiny vision-llm [moondream](https://github.com/vikhyat/moondream)

2.  **embed**: window and embed each image's text description using a popular embedding model - [sentence-transformers/all-MiniLM-L6-v2](https://huggingface.co/sentence-transformers/all-MiniLM-L6-v2)

3.  **index**: index the embeddings in an open source and local vector base [faiss database](https://github.com/facebookresearch/faiss) and references connecting the embeddings to their images in the greatest little db of all time - [sqlite](https://sqlite.org/)

### Pipeline overview - standard version

This meme search pipeline is written in pure Python and is built using the following open source components:

- [moondream](https://github.com/vikhyat/moondream): a tiny, kickass vision language model used for image captioning / extracting image text
- [all-MiniLM-L6-v2](https://huggingface.co/sentence-transformers/all-MiniLM-L6-v2): a very popular text embedding model
- [faiss](https://github.com/facebookresearch/faiss): a fast and efficient vector db
- [sqlite](https://sqlite.org/): the greatest database of all time, used for data indexing
- [streamlit](https://github.com/streamlit/streamlit): for serving up the app

### Running tests - standard version

Tests can be run by first installing the test requirements as

```sh
pip install -r requirements.test
```

Then the test suite can be run as

```sh
python -m pytest tests/
```

## Meme search - pro version

### Features - pro version

The pro version of meme search builds on the standard version, adding an array of features requested by the community.

<p align="center">
  <div style="display: grid; grid-template-columns: repeat(2, 1fr); gap: 10px;">
    <figure>
      <img align="center" src="https://github.com/jermwatt/readme_gifs/blob/main/meme-search-pro-search-example.gif" height="225">
      <figcaption>Search</figcaption>
    </figure>
    <figure>
      <img align="center" src="https://github.com/jermwatt/readme_gifs/blob/main/meme-search-pro-edit-example.gif" height="225">
      <figcaption>Edit</figcaption>
    </figure>
    <figure>
      <img align="center" src="https://github.com/jermwatt/readme_gifs/blob/main/meme-search-pro-filters-example.gif" height="225">
      <figcaption>Filter</figcaption>
    </figure>
    <figure>
      <img align="center" src="https://github.com/jermwatt/readme_gifs/blob/main/meme-search-generate-example.gif" height="225">
      <figcaption>Generate</figcaption>
    </figure>
  </div>
</p>

These additional features include:

1.  **Auto-Generate Meme Descriptions**

    Target specific memes for auto-description generation (instead of applying to your entire directory).

2.  **Manual Meme Description Editing**

    Edit or add descriptions manually for better search results, no need to wait for auto-generation if you don't want to.

3.  **Tags**

    Create, edit, and assign tags to memes for better organization and search filtering.

4.  **Faster Vector Search**

    Powered by Postgres and pgvector, enjoy faster keyword and vector searches with streamlined database transactions.

5.  **Keyword Search**

    Pro adds traditional keyword search in addition to semantic/vector search.

6.  **Directory Paths**

    Organize your memes across multiple subdirectories—no need to store everything in one folder.

7.  **New Organizational Tools**

    Filter by tags, directory paths, and description embeddings, plus toggle between keyword and vector search for more control.

### Installation instructions - pro version

To start up the pro version of meme search pull this repository and start the server cluster with docker-compose

```sh
docker compose -f docker-compose-pro.yml up
```

This pulls and starts containers for the app, database, and auto description generator. The app itself will run on port `3000` and is available at

```sh
http://localhost:3000
```

To start the app alone pull the repo and cd into the `meme_search/meme_search_pro/meme_search_app`. Once there execute the following to start the app in development mode

```sh
./bin/dev
```

When doing this ensure you have an available Postgres instance running locally on port `5432`.

### Index your memes - pro version

With the pro version you can index your memes by creating your own descriptions, or by generating descriptions automatically, as illustrated below.

### Pipeline overview - pro version

The pro version pipeline contains many of the [components of the standard version](#pipeline-overview---standard-version), with some variationa and several additional components.

- the app - along with its enhanced features - is built using [Ruby on Rails](https://rubyonrails.org/)
- a ruby version [of the same embedding model] is used in place of the Pythonic version
- a single Postgres database is used in place of the duo used with the standard version
- the auto generator is isolated in its own image / container to allow for better maintainance, queueing, and cancellation

### Running tests - pro version

To run tests locally pull the repo and cd into the `meme_search/meme_search_pro/meme_search_app` directory. Once there tests can be executed

```sh
rails test test/system
```

When doing this ensure you have an available Postgres instance running locally on port `5432`.

## Changelog

Meme Search is under active development! See the `CHANGELOG.md` in this repo for a record of the most recent changes.

## Feature requests and contributing

Feature requests and contributions are welcome!

See [the discussion section of this repository](https://github.com/neonwatty/meme_search/discussions) for suggested enhancements to contribute to / weight in on!

Please see `CONTRIBUTING.md` for some boilerplate ground rules for contributing.
