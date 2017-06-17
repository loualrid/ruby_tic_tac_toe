## Ruby Tic Tac Toe

## Features

* Terminal-table UI for the game
* Custom game sizes (X by X)
* Start as either X or O


## Configuration

### Initial Setup (RVM)

Assuming RVM is installed, cd to the root of the project and run `bundle install` (you will need to install ruby-2.3.1 if you don't have it already)

### Initial Setup (others)

This project was setup on ruby-2.3.1 but can be run on any ruby greater than 1.9.1, when the configuration is set, just run `bundle install`.

### Running the game

To run the game, `bundle exec rttt`. `bundle exec ttt` or `bundle exec ruby_tic_tac_toe` also work.

### Running the tests

The tests are standard rspec, nothing special:

```
bundle exec rspec
```
