# frozen_string_literal: true

require 'selenium-webdriver'

d = Selenium::WebDriver.for :chrome

gmail = ARGV[0]
password = ARGV[1]

def fill_input(d, element_name, element_value, input_value)
  d&.find_element(element_name, element_value)&.send_keys(input_value)
  d&.find_element(element_name, element_value).send_keys(:enter)
  sleep 2 
end

d.get "https://accounts.google.com/ServiceLogin/identifier"
sleep 2
fill_input(d, :id, 'identifierId', gmail)
fill_input(d, :class, 'zHQkBf', password)
d.get "https://www.youtube.com/comments"
sleep 2
d.execute_script("window.scrollTo(0, document.body.scrollHeight);")
sleep 2
d&.find_element(:id, 'yt-comments-paginator')&.click
sleep 5

begin
 hearts = d&.find_elements(:class, 'creator-heart-big-unhearted')
 hearts.each do |heart|
  p heart
  heart.click
  sleep 1
 end
 p "Liked heart: #{hearts.count}"
rescue Selenium::WebDriver::Error::NoSuchElementError
 exit_with_error('指定した要素が存在しません')
end
