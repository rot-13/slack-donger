require 'net/http'

module Slackhook

  SLACKHOOK_URL = ENV['SLACKHOOK_URL']

  def self.post(message, channel)
    Net::HTTP.post_form(URI(SLACKHOOK_URL), username: 'donger-bot', text: message, channel: channel)
  end

end
