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
  end
end
