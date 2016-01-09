# Change log of httpotemkin

## Version 0.0.6

* Add API endpoints of OBS for testing pushing RPMs in yes_ship_it

## Version 0.0.5

* Don't try to stop client in `down` method
* Add dependencies for yes_ship_it

## Version 0.0.4

* Add command to stop client container in RSpec tests

## Version 0.0.3

* Capture stderr and exit code when running commands on the client

## Version 0.0.2

* Support running servers and clients separate from executing the test. This
  allows to share the same container instances between tests, where the state
  of the container doesn't change between tests.

## Version 0.0.1

* Initial release
