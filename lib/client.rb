module Httpotemkin
  class Client
    def initialize(containers)
      @containers = containers
    end

    def execute(cmd)
      @out = @containers.exec_client(cmd)
    end

    def exit_code
      0
    end

    def out
      @out
    end

    def err
      ""
    end

    def inject_tarball(filename)
      Cheetah.run(["cat", filename], ["docker", "cp", "-", "client:/"])
    end

    def install_gem_from_spec(specfile)
      Dir.chdir(File.dirname(specfile)) do
        out = Cheetah.run(["gem", "build", File.basename(specfile)],
          stdout: :capture)
        gemfile = out[/File: (.*)\n/, 1]
        @containers.run_docker(["cp", gemfile, "client:/tmp"])
        @containers.run_docker(["exec", "client", "gem", "install", "--local",
          File.join("/tmp", gemfile)])
      end
    end
  end
end
