require 'uri'
require 'httparty'
require 'nokogiri'

module Dongers

  class NonexistentCategory < StandardError; end
  class NoDongersFound < StandardError; end

  HOST = 'dongerlist.com'
  CATEGORY_PATH = '/category/%s'
  DONGER_HTML_CLASS = '.copy-donger'
  DONGER_TEXT_ATTRIBUTE = 'data-clipboard-text'

  CATEGORIES = ['All', 'Ameno', 'Angry', 'Animal', 'Brick', 'Cool', 'Cracker', 'Crazy', 'Cry', 'Cute', 'Dance', 'Dead', 'Donger', 'Dunno', 'Excited', 'Fight', 'Finger', 'Flex', 'Flip', 'Flower', 'Glasses', 'Gun', 'Happy', 'Lenny', 'Lower', 'Mad', 'Magic', 'Man', 'Meh', 'Mob', 'Monocle', 'Point', 'Pyramid', 'Raise', 'Run', 'Sad', 'Scared', 'Scary', 'Shocked', 'Spider', 'Surprised', 'Sword', 'Table', 'Throw', 'Tree', 'Ugly', 'Upset', 'Walk', 'Wall', 'Why']

  def self.get(category = '')
    raise NonexistentCategory.new if !category.empty? && !CATEGORIES.include?(category)

    path = category ? (CATEGORY_PATH % category) : '/'
    url = URI.join(HOST, path)

    raw_html = HTTParty.get(url, headers: {'User-Agent' => ''}).body
    dongers = Nokogiri::HTML(raw_html).css(DONGER_HTML_CLASS)
    raise NoDongersFound.new if dongers.empty?

    dongers[rand(dongers.count)][DONGER_TEXT_ATTRIBUTE]
  end
end
