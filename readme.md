# Chomp
[Chomp](https://letschomp.herokuapp.com) is a food recommendation web app that helps groups decide on where to eat in Singapore. It features a recommendation algorithm, email notifications and real world data provided from [STB API](https://tih-dev.stb.gov.sg/).

## Table of Contents
- [Chomp](#chomp)
  - [Table of Contents](#table-of-contents)
  - [General Information](#general-information)
  - [Technologies Used](#technologies-used)
  - [Features](#features)
  - [Screenshots](#screenshots)
  - [Setup](#setup)
  - [Usage](#usage)
  - [Project Status](#project-status)
  - [Room for Improvement](#room-for-improvement)
  - [Contributing](#contributing)
  - [Acknowledgements](#acknowledgements)


## General Information
- Chomp is made with mobile-first design in mind, so not all pages will look as nice on desktop view
- It intends to help groups of friends who can't come to a consensus on where to eat whenever they want to plan a gathering together
- The main goal of the project was to be able to suggest one restaurant to a group of people based on their input budget and input preferred location
- This was the Final Project for Le Wagon's Fullstack Web Development bootcamp


## Technologies Used
- Ruby
- Ruby on Rails (6.0)
- HTML
- CSS3
- SCSS
- Sidekiq
- JavaScript ES6
- Stimulus (JS framework)
- Refer to Gemfile.lock for all the other tools used


## Features
List the ready features here:
- Able to start a group session for collecting friends' inputs
- Can create an account easily with Google Sign-in
- Can review restaurants and see Google Map's rating
- Can edit reviews on the restaurant page
- Can favorite restaurants
- Can view favorited list
- Can access restaurant's website if they were provided
- Can view past groups that users have taken part in and left an input
- Can receive email of the result of the chosen restaurant if the users who took part in the group registered with an email
- Can limit the number of inputs so when the limit is hit, the group session will stop collecting responses from users and select a restaurant as a result
- Can set a time limit for users to take part in a group session, and a restaurant result is created after the time limit is hit
- Users who receives the invitation link to take part in a group session do not have to sign up for an account to use the service


## Screenshots
![Example screenshot](https://i.imgur.com/AP88Wuy.png)
![Example screenshot](https://i.imgur.com/mklwJhb.png)
![Example screenshot](https://i.imgur.com/01z76Wv.png)


## Setup
1. Clone the project at the desired parent location with
```
git clone git@github.com:TeeWhyKay/Chomp.git
```
2. Run the following commands to start the server locally:
```
bundle install
```
```
yarn install
```
```
rails db:create db:migrate db:seed
```
*Note, you will need certain API keys for seeding and certain features to work. The list of keys you need can be found in **.env.sample**.*

If you don't have Redis installed, run:
```
# On OSX
brew update
brew install redis
brew services start redis
```
```
# Ubuntu
sudo apt-get install redis-server
```

Lastly, you can start the server with:
```
rails s
```
You may want to load Sidekiq on another terminal if you want to receive the emails for restaurant results:
```
sidekiq
```

*Please contact any of the contributing members if the setup does not work*

## Usage
1. Create an account
2. At the landing page, create a group
3. Share the invite link with your friends
4. Input your preferences
5. (Optional) Wait for more input from other people
6. Ask Chomp "Show me where to eat" (Can be accessed with the invite link (it should show "Preferences Submitted") or My Dashboard in the account drop-down at the top right of the page)
7. Get redirected to a restaurant page that shows details on an actual restaurant in Singapore

## Project Status
Project is: _no longer being actively worked on_.

We only created this as a Final Project to learn how to create a product from scratch with RoR and other skills picked up in Le Wagon. As we have graduateed from the course, we will not be actively contributing to the project.

## Room for Improvement

Room for improvement:
- Refactoring of the code
- Find a way to access the real budget range of all restaurants (the budget range of each restaurants is currently fake)
- Make a desktop-friendly design

To do:
- tbd

## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

## Acknowledgements
- This project was lead by [TeeWhyKay](https://github.com/TeeWhyKay)
- Many thanks to the teachers of batch 691 at Le Wagon
