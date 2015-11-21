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
  end
end
