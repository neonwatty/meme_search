function loadHTML(filePath, containerId) {
  fetch(filePath)
    .then((response) => {
      if (!response.ok) {
        throw new Error("Network response was not ok");
      }
      return response.text();
    })
    .then((data) => {
      document.getElementById(containerId).innerHTML = data;
    })
    .catch((error) => console.error("Error loading the partial:", error));
}
