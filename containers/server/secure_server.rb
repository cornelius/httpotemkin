#!/usr/bin/ruby

require "sinatra"
require "thin"

class SecureServer < ::Thin::Backends::TcpServer
  def initialize(host, port, options)
    super(host, port)
    @ssl = true
    @ssl_options = options
  end
end

configure do
  set :environment, :production
  set :bind, '0.0.0.0'
  set :port, 443
  set :server, "thin"
  class << settings
    def server_settings
      {
        :backend          => SecureServer,
        :private_key_file => File.dirname(__FILE__) + "/server.key",
        :cert_chain_file  => File.dirname(__FILE__) + "/server.crt",
        :verify_peer      => false
      }
    end
  end
end

get '/' do
  "Hopss\n"
end
