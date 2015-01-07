require 'net/http'
require 'nokogiri'

module Dongers

  class NonexistentCategory < StandardError; end

  HOST = 'dongerlist.com'
  CATEGORY_PATH = '/category/%s'
  DONGER_HTML_CLASS = '.copy-donger'
  DONGER_TEXT_ATTRIBUTE = 'data-clipboard-text'

  CATEGORIES = ['All', 'Ameno', 'Angry', 'Animal', 'Brick', 'Cool', 'Cracker', 'Crazy', 'Cry', 'Cute', 'Dance', 'Dead', 'Donger', 'Dunno', 'Excited', 'Fight', 'Finger', 'Flex', 'Flip', 'Flower', 'Glasses', 'Gun', 'Happy', 'Lenny', 'Lower', 'Mad', 'Magic', 'Man', 'Meh', 'Mob', 'Monocle', 'Point', 'Pyramid', 'Raise', 'Run', 'Sad', 'Scared', 'Scary', 'Shocked', 'Spider', 'Surprised', 'Sword', 'Table', 'Throw', 'Tree', 'Ugly', 'Upset', 'Walk', 'Wall', 'Why']

  def self.get(category = '')
    raise NonexistentCategory.new if !category.empty? && !CATEGORIES.include?(category)

    path = category ? (CATEGORY_PATH % category) : '/'
    http = Net::HTTP.new(HOST)
    req = Net::HTTP::Get.new(path, 'User-Agent' => '')

    raw_html = http.request(req).body
    dongers = Nokogiri::HTML(raw_html).css(DONGER_HTML_CLASS)
    dongers.empty? ? NOT_FOUND : dongers[rand(dongers.count)][DONGER_TEXT_ATTRIBUTE]
  end
end
