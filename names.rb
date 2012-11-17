require 'nokogiri'
require 'open-uri'
require 'pry'

doc = Nokogiri::HTML(open('http://nosql-database.org/'))

names = []
doc.css('section').each do |section|
  section.css('article h3').each { |h3| names << h3.content  }
  section.css('article span.grey').each do |span|
    names << span[1..-2].try(:split, ",") unless span[1..-2].nil?
  end
end
names.map!{|name| name.gsub(/[\r\n\t]*/, "").gsub(/:\z/, "") }
puts names.join(", ")
