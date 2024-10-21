import subprocess
import pytest
import time
from tests import STREAMLIT_APP_FILE


@pytest.fixture(scope="module")
def start_streamlit_app():
    cmd = f"python -m streamlit run {STREAMLIT_APP_FILE} --server.headless true"
    process = subprocess.Popen(
        cmd, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE
    )
    time.sleep(5)
    yield process
    process.terminate()
    process.wait()


def test_streamlit(subtests, start_streamlit_app):
    with subtests.test(msg="streamlit up"):
        assert start_streamlit_app.poll() is None, "Streamlit app failed to start"

    with subtests.test(msg="streamlit down"):
        start_streamlit_app.terminate()
        time.sleep(2)
        assert start_streamlit_app.poll() is not None, "Streamlit app failed to stop"
