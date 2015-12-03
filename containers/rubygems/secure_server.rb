#!/usr/bin/ruby

require "sinatra"

require_relative "../server/server_base.rb"

CERT_DIR = File.dirname(__FILE__)

configure_sinatra

get '/' do
  "I'm the secure rubygems server\n"
end

post '/api/v1/gems' do
  "Successfully registered gem: red_herring (0.0.2)"
end

get '/api/v1/versions/red_herring.json' do
  json = <<EOT
[{
  "authors": "Cornelius Schumacher",
  "built_at": "2015-06-20T00:00:00.000Z",
  "created_at": "2015-06-20T06:57:40.675Z",
  "description": "This is a red herring.",
  "downloads_count": 371,
  "metadata": {},
  "number": "0.0.1",
  "summary": "Red herring",
  "platform": "ruby",
  "ruby_version": "\u003e= 0",
  "prerelease": false,
  "licenses": ["MIT"],
  "requirements": [],
  "sha": "8afa714a16b34800a3f4e7aefcab871cf98aca33d02758e9c9d658cbf4bd740b"
}]
EOT
  json
end
