require 'nokogiri'

doc = Nokogiri::HTML(open("https://www.w3schools.com/html/html_tables.asp"))
tables = doc.search('#customers')
puts tables
