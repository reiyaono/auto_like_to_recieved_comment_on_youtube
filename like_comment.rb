# frozen_string_literal: true

require 'selenium-webdriver'

d = Selenium::WebDriver.for :chrome

gmail = ARGV[0]
password = ARGV[1]

d.get "https://accounts.google.com/ServiceLogin/identifier"
sleep 2
d&.find_element(:id, 'identifierId')&.send_keys(gmail)
d&.find_element(:id, 'identifierId').send_keys(:enter)
sleep 1
d&.find_element(:class, 'zHQkBf')&.send_keys(password)
d&.find_element(:class, 'zHQkBf')&.send_keys(:enter)
sleep 2
d.get "https://www.youtube.com/comments"
sleep 2
d.execute_script("window.scrollTo(0, document.body.scrollHeight);")
sleep 4

begin
 hearts = d&.find_elements(:class, 'creator-heart-big-unhearted')
 hearts.each do |heart|
  p heart
 end
 p "Liked heart: #{hearts.count}"
rescue Selenium::WebDriver::Error::NoSuchElementError
 exit_with_error('指定した要素が存在しません')
end
