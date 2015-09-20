#!/usr/bin/ruby

require "sinatra/base"
require "webrick"
require "webrick/https"
require "openssl"

certificate = File.read("server.crt")
key = File.read("server.key")

webrick_options = {
  Port: 4568,
  SSLEnable: true,
  SSLVerifyClient: OpenSSL::SSL::VERIFY_NONE,
  SSLCertificate: OpenSSL::X509::Certificate.new(certificate),
  SSLPrivateKey: OpenSSL::PKey::RSA.new(key)
}

class SecureServer < Sinatra::Base
  get "/" do
    "jupss\n"
  end
end

Rack::Handler::WEBrick.run(SecureServer, webrick_options)
