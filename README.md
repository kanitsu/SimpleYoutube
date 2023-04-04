# SimpleYoutube
Simple Youtube playlist viewer for iOS.

---
## Set Up
To use the app, you will need to obtain an API key from Google data API that grants access to the YouTube API. Refer to this [guide](https://developers.google.com/youtube/v3/getting-started) for instructions on how to obtain the key. Once you have obtained the API key, follow the below steps:

1. Open Xcode.
2. Set the API key to `YOUTUBE_API_KEY` in the info.plist file.
3. Set the desired Playlist ID to `YOUTUBE_PLAYLIST_ID` in the info.plist file. Please note that a default ID is already provided, but you may need to change it to match your desired playlist.
4. You are now ready to run the app.

---
## Technical Details
### 1. Video Player
Due to YouTube's terms of service, our app is restricted to using the player provided by YouTube, which utilizes `WKWebView`. Currently, videos played in `WKWebView` on iOS will automatically switch to fullscreen mode.

### 2. Owner / Channel Image
Unfortunately, the video owner's or channel's image URL cannot be retrieved from the playlist items API. Instead, it needs to be queried individually for each video via the channel API. To minimize network overload, we have implemented a cache that records the channel ID and its corresponding image URL.

---
## How to Use
### 1. Playlist Page
The app initially displays 30 videos. If you scroll down to the bottom of the screen, an additional 20 videos will be loaded. To access the search feature, tap the magnifying glass icon to open the search dialog. To watch a particular video, simply tap on its thumbnail, and the video page will open.

<img src="https://raw.githubusercontent.com/kanitsu/SimpleYoutube/main/resources/playlist.jpg" width=200 alt="Playlist">&nbsp;
<img src="https://raw.githubusercontent.com/kanitsu/SimpleYoutube/main/resources/playlist_loading.jpg" width=200 alt="Playlist Loading">

To search for videos in a playlist that contain a specific term in their title, type the term into the text input and then tap the "Search" button. If multiple words are entered, all titles containing at least one of the words will be displayed. If you want to cancel the search, simply tap the "Cancel" button. To clear any previously displayed search results, leave the text input blank and tap "Search".

<img src="https://raw.githubusercontent.com/kanitsu/SimpleYoutube/main/resources/playlist_search.jpg" width=200 alt="Search dialog">&nbsp;
<img src="https://raw.githubusercontent.com/kanitsu/SimpleYoutube/main/resources/playlist_search_result.jpg" width=200 alt="Playlist Search Result">

As soon as the search results are displayed, the app's title will be replaced with the search term. Additionally, scrolling down to the bottom of the screen will trigger the loading of more content, filtered by the search term. However, if there are no videos with titles that match the search term, the loading process may appear to be stuck. To resolve this, try scrolling up and down a few times. If you want to clear the search results, tap the "Cancel Search" button.

### 2. Video Page
If you tap on a video thumbnail, it will start playing the video. To hide or show the video description or comments, tap on the "Hide/Show Description/Comments" button. Additionally, to load more comments on the video, scroll to the bottom of the comments section.

<img src="https://raw.githubusercontent.com/kanitsu/SimpleYoutube/main/resources/video.jpg" width=200 alt="Video">&nbsp;
<img src="https://raw.githubusercontent.com/kanitsu/SimpleYoutube/main/resources/video_hide_comment.jpg" width=200 alt="Video Hide Comment">&nbsp;
<img src="https://raw.githubusercontent.com/kanitsu/SimpleYoutube/main/resources/video_hide_description.jpg" width=200 alt="Video Hide Description">
