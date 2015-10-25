require_relative "spec_helper"

include CliTester
include GivenFilesystemSpecHelpers

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
      with_stubbed_binary("bin/status/docker") do
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

  describe "up" do
    it "starts containers" do
      with_stubbed_binary("bin/up/docker") do
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
  end

  describe "down" do
    it "stops containers" do
      with_stubbed_binary("bin/down/docker") do
        expected_output = <<-EOT
Stopping server containers
docker rm -f rubygems
rubygems
docker rm -f api.rubygems
api.rubygems
docker rm -f obs
obs
        EOT
        expect(run_command(args: ["down"])).to exit_with_success(expected_output)
      end
    end
  end

  describe "client" do
    it "runs client" do
      with_stubbed_binary("bin/client/docker") do
        expected_output = <<-EOT
docker run --link=rubygems:rubygems.org --link=api.rubygems:api.rubygems.org --link=obs:api.opensuse.org client
Hopss
Hopss
Hopss
        EOT
        expect(run_command(args: ["client"])).to exit_with_success(expected_output)
      end
    end
  end

  describe "run" do
    use_given_filesystem

    before(:each) do
      @logs_dir = given_directory
      ENV["HTTPOTEMKIN_LOGS_DIR"] = @logs_dir
    end

    it "runs test and succeeds" do
      with_stubbed_binary("bin/run.success/docker") do
        expected_output = <<-EOT
Running tests
docker run --name=rubygems -d rubygems
docker run --name=api.rubygems -d api.rubygems
docker run --name=obs -d obs
docker run --link=rubygems:rubygems.org --link=api.rubygems:api.rubygems.org --link=obs:api.opensuse.org client
--- Start Test ---
Hopss
Hopss
Hopss
---- End Test ----
docker logs rubygems
docker rm -f rubygems
docker logs api.rubygems
docker rm -f api.rubygems
docker logs obs
docker rm -f obs

Success.
        EOT
        expect(run_command(args: ["run"])).to exit_with_success(expected_output)
        expect(File.exist?(File.join(@logs_dir, "rubygems.log"))).to be(true)
        expect(File.exist?(File.join(@logs_dir, "api.rubygems.log"))).to be(true)
        expect(File.exist?(File.join(@logs_dir, "obs.log"))).to be(true)
      end
    end

    it "runs test and fails" do
      with_stubbed_binary("bin/run.failure/docker") do
        expected_output = <<-EOT
Running tests
docker run --name=rubygems -d rubygems
docker run --name=api.rubygems -d api.rubygems
docker run --name=obs -d obs
docker run --link=rubygems:rubygems.org --link=api.rubygems:api.rubygems.org --link=obs:api.opensuse.org client
--- Start Test ---
error
---- End Test ----
docker logs rubygems
docker rm -f rubygems
docker logs api.rubygems
docker rm -f api.rubygems
docker logs obs
docker rm -f obs

Failed.

Expected output:
Hopss
Hopss
Hopss

Actual output:
error
        EOT
        expect(run_command(args: ["run"])).to exit_with_error(1, "", expected_output)
      end
    end
  end
end
