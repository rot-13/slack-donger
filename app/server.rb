require 'sinatra'
require_relative './dongers'
require_relative './slackhook'

SLACK_TOKEN = ENV['SLACK_TOKEN']

CATEGORIES_COMMAND = 'categories'
NONEXISTENT_CATEGORY = "That category doesn't exist ᕕ(˵•̀෴•́˵)ᕗ"

post '/donger' do
  halt 401 unless request['token'] == SLACK_TOKEN

  text = request['text']
  if text == CATEGORIES_COMMAND
    "The available categories are: \n" << Dongers::CATEGORIES.join("\n")
  else
    begin
      donger = Dongers.get(request['text'])
      Slackhook.post(donger, request['channel_name'])
    rescue Dongers::NonexistentCategory
      NONEXISTENT_CATEGORY
    end
  end
end
