# effective_coffee

A new Flutter project about coffee shop. Alexander Safronov, 2024. 

## General info

App uses:
- FCM,
- YandexMapKit,
- BLoC (+equatable),
- drift,
- dio,
- shared_preferences,
- scrollable_positioned_list,
- build_runner.

Flutter 3.19.5

Dart 3.3.3

Android min SDK version 21 and ext.kotlin.version 1.9.10  

## Startup

Clone repo, add your google-services.json, then flutter run --dart-define API_KEY=<your_api_key>, where your_api_key is Yandex Maps API key for YandexMapKit.

## Screenshots

<img src="https://i.ibb.co/VqkWdSF/photo-2024-04-18-03-38-44.jpg" width="200">
<img src="https://i.ibb.co/S0VZ0vx/photo-2024-04-18-03-38-55.jpg" width="200"> 
<img src="https://i.ibb.co/1JjWksw/photo-2024-04-18-03-38-59.jpg" width="200">
<img src="https://i.ibb.co/Mpr2qTp/Screenshot-2024-03-25-04-00-22-78-46e2ebb9dae5c7f04dadf1b159c58b8b.jpg" width="200">
<img src="https://i.ibb.co/dthBcbR/Photo-2.jpg" width="200">

## Known issues

- Fast scroll of menu can cause bug -- previous categories won't be fetched, cause fetching depends on scroll offset.
- In addition to the first point, there is a small chance that category in appbar won't be changed on tap, because data can fetch and move the category header out of screen.
- 1/856 coffee with long name (hello @ayusavin) breaks the coffee card design
