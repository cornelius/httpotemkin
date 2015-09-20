#!/usr/bin/ruby

require "sinatra"

get '/' do
  "Jups\n"
end

get "/hello" do
  "world\n"
end

get "/*" do
  "all the rest\n"
end
