# CityBikes

iOS App for displaying bike stations in Warsaw.

## Technologies
-   SwiftUI
-   MVVM Architecture
-   Combine
-   JSON
-   REST API

## CityBikes API
The application uses data provided by the CityBikes API. 
https://api.citybik.es/v2/

## App Features

* displaying stations as a list
* displaying info about each station:
    * number of free bikes
    * number of free slots
    * distance between user and station in real time
    * adress
* showing station on map
* showing exact address only in map view (because of reverse geocoding CLGeocoder API calls limit)
* showing the view of the street where the station is located 

## Demo
![gif1](Assets/gif1.gif)
