require 'uri'
require 'httparty'
require 'nokogiri'

module Dongers

  class NonexistentCategory < StandardError; end
  class NoDongersFound < StandardError; end

  HOST = 'http://dongerlist.com'
  CATEGORY_PATH = '/category/'
  DONGER_HTML_CLASS = '.copy-donger'
  DONGER_TEXT_ATTRIBUTE = 'data-clipboard-text'

  CATEGORIES = ['Ameno', 'Angry', 'Animal', 'Brick', 'Cool', 'Cracker', 'Crazy', 'Cry', 'Cute', 'Dance', 'Dead', 'Donger', 'Dunno', 'Excited', 'Fight', 'Finger', 'Flex', 'Flip', 'Flower', 'Glasses', 'Gun', 'Happy', 'Lenny', 'Lower', 'Mad', 'Magic', 'Man', 'Meh', 'Mob', 'Monocle', 'Point', 'Pyramid', 'Raise', 'Run', 'Sad', 'Scared', 'Scary', 'Shocked', 'Spider', 'Surprised', 'Sword', 'Table', 'Throw', 'Tree', 'Ugly', 'Upset', 'Walk', 'Wall', 'Why']

  def self.get(category = '')
    raise NonexistentCategory.new if !category.empty? && !CATEGORIES.include?(category)

    url = category.empty? ? HOST : URI.join(HOST, CATEGORY_PATH, category)
    raw_html = HTTParty.get(url, headers: {'User-Agent' => ''}).body
    dongers = Nokogiri::HTML(raw_html).css(DONGER_HTML_CLASS)
    raise NoDongersFound.new if dongers.empty?

    dongers[rand(dongers.count)][DONGER_TEXT_ATTRIBUTE]
  end
end
