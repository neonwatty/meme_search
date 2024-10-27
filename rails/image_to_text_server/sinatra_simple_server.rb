require 'sinatra'
require 'uri'
require 'net/http'

get '/send' do
  uri = URI('http://localhost:8000')
  res = Net::HTTP.get_response(uri)
  puts res.body if res.is_a?(Net::HTTPSuccess)
end

get '/receive' do
  puts 'Hello world!'
  content_type :json
  { song: "Wake me Up" }.to_json
end