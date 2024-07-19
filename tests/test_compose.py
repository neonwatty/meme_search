import subprocess
from tests import cwd, CONTAINER_NAME


def terminal_process(command: list) -> int:
    output = subprocess.Popen(
        command,
        cwd=cwd,
        stdin=None,
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
    )
    return output.wait()


def test_compose(subtests):
    up_cmd = ["docker", "compose", "up", "-d"]
    ps_cmd = "docker-compose ps"
    down_cmd = ["docker", "compose", "down"]
    
    with subtests.test(msg="compose down"):
        code = terminal_process(down_cmd)
        assert code == 0, "compose down failed"

    with subtests.test(msg="compose up"):
        code = terminal_process(up_cmd)
        assert code == 0, "compose up failed"

    with subtests.test(msg="docker ps"):
        result = subprocess.run(ps_cmd, shell=True, check=True, capture_output=True)
        assert result.returncode == 0, "Failed to run docker-compose ps"
        assert (
            bytes(CONTAINER_NAME, "utf-8") in result.stdout
        ), f"{CONTAINER_NAME} container not running"

    with subtests.test(msg="compose down"):
        code = terminal_process(down_cmd)
        assert code == 0, "compose down failed"
