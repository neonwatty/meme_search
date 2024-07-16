from meme_search import base_dir, sqlite_db_path, vector_db_path
from meme_search.utilities.query import complete_query
import streamlit as st

st.set_page_config(page_title="Meme Search")


# search bar taken from --> https://discuss.streamlit.io/t/creating-a-nicely-formatted-search-field/1804/2
def local_css(file_name):
    with open(file_name) as f:
        st.markdown(f"<style>{f.read()}</style>", unsafe_allow_html=True)


def remote_css(url):
    st.markdown(f'<link href="{url}" rel="stylesheet">', unsafe_allow_html=True)


local_css(base_dir + "/style.css")
remote_css("https://fonts.googleapis.com/icon?family=Material+Icons")

# icon("search")
buff, col, buff2 = st.columns([1, 4, 1])

selected = col.text_input(label="search for meme", placeholder="search for a meme")
if selected:
    results = complete_query(selected, vector_db_path, sqlite_db_path)
    img_paths = [v["img_path"] for v in results]
    for result in results:
        with col.container(border=True):
            st.image(
                result["img_path"],
                output_format="auto",
                caption=f'{result["full_description"]} (query distance = {result["distance"]})',
            )
