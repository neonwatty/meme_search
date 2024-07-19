import time
from meme_search import base_dir
from meme_search.utilities.query import complete_query
from meme_search.utilities.create import process
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
with st.container():
    with st.container(border=True):
        input_col, button_col = st.columns([6, 2])

    with button_col:
        st.empty()
        refresh_index_button = st.button("refresh index", type="primary")
        if refresh_index_button:
            process_start = st.warning("refreshing...")
            val = process()
            if val:
                process_start.empty()
                success = st.success("index updated!")
                time.sleep(2)
                process_start.empty()
                success.empty()
            else:
                process_start.empty()
                warning = st.warning("no refresh needed!")
                time.sleep(2)
                warning.empty()

    selected = input_col.text_input(label="meme search", placeholder="search for your meme", label_visibility="collapsed")
    if selected:
        results = complete_query(selected)
        img_paths = [v["img_path"] for v in results]
        with st.container(border=True):
            for result in results:
                with st.container(border=True):
                    st.image(
                        result["img_path"],
                        output_format="auto",
                        caption=f'{result["full_description"]} (query distance = {result["distance"]})',
                    )
