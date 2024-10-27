require 'sinatra'

get '/' do
  puts 'Hello world!'
  content_type :json
  { song: "Wake me Up" }.to_json
end