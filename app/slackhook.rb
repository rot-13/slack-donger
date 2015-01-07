require 'net/http'

module Slackhook

  SLACKHOOK_URL = ENV['SLACKHOOK_URL']

  def self.post(message, channel)
    Net::HTTP.post_form(SLACKHOOK_URL, username: 'donger-bot', message: message, channel: channel)
  end

end
