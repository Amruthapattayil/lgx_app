# Flutter Mini API App

A Flutter application that fetches posts from an API, supports search, offline caching, and dark and light themes.

## Features

- Login form validation.
- Fetch posts from REST API.
- Search posts by title.
- Store posts locally using Hive.
- Access cached posts offline.
- Switch between dark and light themes.
- Save theme preferences using SharedPreferences.

## Technologies Used

- Flutter   – Mobile app development.
- Dart      – Programming language.
- HTTP      – API requests.
- REST API  – Fetching post data.
- Hive      – Local data storage.
- SharedPreferences – Saving theme preferences.

## API Reference

API Provider: JSONPlaceholder

Endpoint:

https://jsonplaceholder.typicode.com/posts

Used to fetch sample post data for the application.

## Installation and Setup

Prerequisites:

Flutter SDK
Dart SDK
Visual Studio Code or Android Studio
Android emulator or physical device

1. Clone the repository:

git clone <https://github.com/Amruthapattayil/lgx_app>

2. Open the project folder:

cd lgx_app

3. Install the dependencies:

flutter pub get

4. Run the application:

flutter run

## Application Workflow

API Data Fetching
- Fetches posts from JSONPlaceholder API.
- Decodes JSON data and displays posts.

 Offline Caching Using Hive
- Loads cached posts from Hive.
- Updates the cache when new API data is available.
- Displays cached posts when offline.

Theme Management Using SharedPreferences
- Saves the selected theme locally.
- Restores dark or light mode when the app restarts.

## Testing

- Email and password validation.
- API fetching and post display.
- Search and debounce functionality.
- Hive data storage and offline access.
- Cache updates after internet reconnection.
- Dark/light theme switching.
- Theme preference persistence after app restart.

## Limitations

- Login includes form validation only; backend authentication is not implemented.
- JSONPlaceholder provides sample data, not production data.

## Author

Amrutha P

- GitHub: [Amrutha Pattayil](https://github.com/Amruthapattayil/lgx_app)