Httpotemkin provides tools to mock HTTP servers for system-level tests. It uses
docker containers to provide mocks of HTTP APIs and Ruby classes which can
be used in tests to execute applications in the environment of the mocked APIs.
This allows to test applications which talk to HTTP APIs without having to
change them in any way for the tests, so that very high-level system tests can
be done in a controlled environment suitable for test driven development.

The tests in `spec/system` provide examples of how tests using httpotemkin can
be written.

## Debugging

When debugging tests (which actually means reverse engineering the protocol of
the service and implementing the required bits) it is convenient to get in a
mode of interactive debugging, where there are containers for the server and
the client under control of a shell. This allows to manually trigger calls from
the client and see the resulting requests in the log of the server. By adapting
the server calls one at a time, it's easily possible to provide the minimal
mocking to make the tests run.

One way to enter the state of debugging a specific test is to add debug code to
the RSpec test, e.g. add a `binding.pry` call just before the client test call
is executed and passing `r.pry` to the `rspec` command. Then you end up in a
state where all containers are started, test data is injected, and you can debug
the calls which are supposed to take place.
