# Sweather Weather

Sweater Weather is the back-end side of a Service-Oriented Architecture application, that allows users to check current, hourly and daily weather across the world as well as planning a road trip along with their end destination's weather information at their time of arrival. This app uses OpenWeather API, Mapquest API, and FLickr API to create endpoints to send to our front end, allowing users to login, create sessions, access weather information around the world, and create road trips.

## Summary

  - [Getting Started](#getting-started)
  - [Running the tests](#running-the-tests)
  - [Built With](#built-with)
  - [Endpoints](#endpoints)
  - [Versioning](#versioning)
  - [Authors](#authors)
  - [Acknowledgments](#acknowledgments)

## Getting Started

To get this application running yourself, please follow these steps:

- Fork and clone this repo
- run `bundle install`
- Go to [OpenWeather API](https://openweathermap.org/api/) and sign up for an API Key
- Go to [MapQuest API](https://developer.mapquest.com/) and sign up for an API Key
- Go to [Flickr API](https://www.flickr.com/services/api/) and sign up for an API Key
- Open `config/application.yml` and store your API Keys as environment varibales
- In your terminal run `rails s` to start your server
- Open Postman and start hitting localhost endpoints!

## Running the tests

To run the tests, follow these commands:

- Make sure you have run a `bundle install`
- Run `bundle exec rspec`
- Run `open coverage` to open your coverage file and inspect further

### Test Coverage

Rspec, VCR, ShouldaMAtchers, Capybara, and SimpleCov were all used.

The full suite is currently at 100% coverage for 723 lines of code. This application is thoroughly tested through happy path, sad path and edge cases. Certain sad paths and edge cases include:

- Getting an invalid parameter (empty string, no parameters, invalid city, invalid state, invalid latitude, invalid longitude, etc)
- Routing a trip that can't be driven
- User authentication (user not existing, passwords not matching, password/email aren't correct, API Key not belonging to user, etc)

## Built With

This application was built utilizing many different gems and frameworks:

- Ruby
- Rails
- Rspec
- Active Record
- Pry
- Fast Json API
- Faraday
- JSON
- Bcrypt
- SimpleCov
- ShouldaMatchers
- Capyabra
- Figaro
- VCR

## Endpoints

### Get Forecast
#### `GET '/forecast'`
- Required parameters: :location

### Get Backgrounds
#### `GET '/backgrounds'`
- Required parameters: :location

### Post Users
#### `POST '/users'`
- Required header parameters (application/json): "email", "password", "password_confirmation"

### Post Sessions
#### `POST '/sessions'`
- Required header parameters (application/json): "email", "password"

### Post Road Trip
#### `POST '/road_trip'`
- Required header parameters (application/json): "origin", "destination", "api_key"

## Versioning

This application is currently on V1.
For any changes in versioning, please check back here.

## Authors

  - **Andrew Johnston** - *Sole Developer* -
    [My Github](https://github.com/avjohnston)
    [My LinkedIn](www.linkedin.com/in/avjohnston)

## Acknowledgments

  - Turing instructors
  - Geocode, Flickr, OpenWeather, Mapquest
