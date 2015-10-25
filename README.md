Httpotemkin provides tools to mock HTTP servers for system-level tests. It uses
docker containers to provide mocks of HTTP APIs and Ruby classes which can
be used in tests to execute applications in the environment of the mocked APIs.
This allows to test applications which talk to HTTP APIs without having to
change them in any way for the tests, so that very high-level system tests can
be done in a controlled environment suitable for test driven development.
