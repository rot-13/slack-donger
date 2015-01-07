require 'json'
require 'httparty'

module Slackhook

  SLACKHOOK_URL = ENV['SLACKHOOK_URL']

  def self.post(message, channel)
    payload = JSON.generate(username: 'donger-bot', text: message, channel: channel)
    HTTParty.post(SLACKHOOK_URL, body: payload)
  end

end
