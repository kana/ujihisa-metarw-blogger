#!/usr/bin/env ruby
require 'net/http'
require 'uri'
require 'rubygems'
require 'nokogiri'

class Net::HTTP
  def self.post(uri, data, header)
    uri = URI.parse(uri)
    new(uri.host).post(uri.path, data, header).body
  end
end

module Blogger
  # post :: String -> IO String
  def self.post(str)
    'ok'
  end

  # text2xml :: String -> String
  def self.text2xml(text)
    lines = text.lines.to_a
    title = lines.shift.strip
    body = lines.join("<br />")
    <<-EOF.gsub(/^\s*\|/, '')
    |<entry xmlns='http://www.w3.org/2005/Atom'>
    |  <title type='text'>#{title}</title>
    |  <content type='xhtml'>
    |    <div xmlns="http://www.w3.org/1999/xhtml">
    |      <p>#{body}</p>
    |    </div>
    |  </content>
    #|  <category scheme="http://www.blogger.com/atom/ns#" term="marriage" />
    #|  <category scheme="http://www.blogger.com/atom/ns#" term="Mr. Darcy" />
    |</entry>
    EOF
  end
end
