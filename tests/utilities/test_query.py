from meme_search import sqlite_db_path, vector_db_path
from meme_search.utilities.query import complete_query
import pytest


test_queries = [
    ("two capsules", "test_meme_5.jpg"),
    ("no", "test_meme_9.jpg")
]


@pytest.mark.parametrize("query, top_result", test_queries)
def test_complete_query(query, top_result):
    unique_img_entries = complete_query(query, vector_db_path, sqlite_db_path)
    assert unique_img_entries[0]["img_path"].split("/")[-1] == top_result
