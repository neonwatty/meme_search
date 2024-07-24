# Change Log
All notable changes to this project will be documented in this file.

## 2024-07-24

Version 1.1.3 released with a range of great updates to docker version of app

- Ability to use Nvidia GPU inside Docker Container added to compose file + other helpful cleanup from @thijsvanloef 
- new action for docker build / docker-compose now pulls image from ghcr repo by default thanks to @jasonyang-ee 
- docker build size roughly cut in half thanks to staged build commit by @StroescuTheo 

## 2024-07-17

### Added

- Core tests added for query, imgs modules, add images re-indexing, remove image re-indexing

- A new "refresh index" button has been introduced to update the index when images are added or removed from the data/input image directory, affecting only the newly added or removed images.


<p align="center">
<img align="center" src="https://github.com/jermwatt/readme_gifs/blob/main/meme_search_refresh_button.gif" height="200">
</p>
