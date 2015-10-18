require_relative "spec_helper"

include CliTester

describe "command line interface" do
  describe "help" do
    it "shows help" do
      expected_output = <<-EOT
Usage: httpotemkin <command>

Testing with HTTP mocks based on containers

Commands:
  status  - Show status of containers
  up      - Start containers
  down    - Stop containters
  client  - Run client
  run     - Run tests
  help    - Show command line help
      EOT
      expect(run_command(args: ["help"])).to exit_with_success(expected_output)
    end
  end

  describe "status" do
    it "shows status" do
      stub_binary("bin/status/docker")

      expected_output = <<-EOT
Status:
  rubygems: up
  api.rubygems: down
  obs: up
      EOT
      expect(run_command(args: ["status"])).to exit_with_success(expected_output)
    end
  end

  describe "up" do
    it "starts containers" do
      stub_binary("bin/up/docker")

      expected_output = <<-EOT
Starting server containers
docker run --name=rubygems -d rubygems
123
docker run --name=api.rubygems -d api.rubygems
123
docker run --name=obs -d obs
123
      EOT
      expect(run_command(args: ["up"])).to exit_with_success(expected_output)
    end
  end

  describe "down" do
    it "stops containers" do
      stub_binary("bin/down/docker")

      expected_output = <<-EOT
Stopping server containers
docker rm -f rubygems
rubygems
docker rm -f api.rubygems
api.rubygems
docker rm -f obs
obs
docker rm -f client
client
      EOT
      expect(run_command(args: ["down"])).to exit_with_success(expected_output)
    end
  end
end
