#!/usr/bin/ruby

require "sinatra"

set :bind, "0.0.0.0"

get '/' do
  "Jups\n"
end

get "/hello" do
  "world\n"
end

get "/*" do
  "all the rest\n"
end
