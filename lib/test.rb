module Httpotemkin
  class Test
    def initialize(out: $stdout)
      @containers = Containers.new
      @containers.out = out
    end

    def add_server(name)
      @containers.add_server(name)
    end

    def run
      @containers.up
      @containers.start_client
      yield Client.new(@containers)
      @containers.stop_client
      @containers.down
    end
  end
end
