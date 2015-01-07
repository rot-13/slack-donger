require 'sinatra'
require_relative './dongers'
require_relative './slackhook'

SLACK_TOKEN = ENV['SLACK_TOKEN']

CATEGORIES_COMMAND = 'categories'
NONEXISTENT_CATEGORY = "That category doesn't exist ᕕ(˵•̀෴•́˵)ᕗ\nTry '/donger categories' for a list of all categories"
NO_DONGERS_FOUND = "There aren't any dongers in that category ┌╏✖_✖╏┘"

post '/donger' do
  halt 401 unless request['token'] == SLACK_TOKEN

  text = request['text'].strip
  if text == CATEGORIES_COMMAND
    "The available categories are: \n" << Dongers::CATEGORIES.join("\n")
  else
    begin
      donger = Dongers.get(text.capitalize)
      Slackhook.post(donger, request['channel_id'])
      nil
    rescue Dongers::NonexistentCategory
      NONEXISTENT_CATEGORY
    rescue Dongers::NoDongersFound
      NO_DONGERS_FOUND
    end
  end
end
