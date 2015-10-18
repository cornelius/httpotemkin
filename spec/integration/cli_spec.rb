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
      stub_binary("bin/docker")

      expected_output = <<-EOT
Status:
  rubygems: up
  api.rubygems: down
  obs: up
      EOT
      expect(run_command(args: ["status"])).to exit_with_success(expected_output)
    end
  end
end
