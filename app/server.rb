require 'sinatra'
require_relative './dongers'

CATEGORIES_COMMAND = 'categories'
NONEXISTENT_CATEGORY = "That category doesn't exist ᕕ(˵•̀෴•́˵)ᕗ\nTry '/donger categories' for a list of all categories"
NO_DONGERS_FOUND = "There aren't any dongers in that category ┌╏✖_✖╏┘"

post '/donger' do
  content_type :json

  text = request['text'].strip
  if text == CATEGORIES_COMMAND
    "The available categories are: \n" << Dongers::CATEGORIES.join("\n")
  else
    begin
      donger = Dongers.get(text.capitalize)
      respond_in_channel donger
    rescue Dongers::NonexistentCategory
      respond NONEXISTENT_CATEGORY
    rescue Dongers::NoDongersFound
      respond NO_DONGERS_FOUND
    end
  end
end

def respond(text)
  {text: text}
end

def respond_in_channel(text)
  {response_type: 'in_channel', text: text}
end