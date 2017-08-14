# Работа с селекторами: http://ruby.bastardsbook.com/chapters/html-parsing/
# Построить XML: http://www.rubydoc.info/github/sparklemotion/nokogiri/Nokogiri/XML/Builder

require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'sqlite3'

pagearr = Nokogiri::XML(open('http://www.remax.ua/SiteMap1.xml'))

newarr = pagearr.xpath('//xmlns:loc')

# отобрал все теги <loc> в которых содержаться url

arr2 = []

newarr.each do |lines|
  arr2 << lines.text + '?Lang=ru-UA'
end

# почистил от лишних тегов

# puts arr2
# puts "========"


@total_listing = arr2.size.to_i
@all_data = Hash.new

puts @total_listing

puts "========"
puts ''
my_time = Time.new

new_page = Nokogiri::HTML(open('http://www.remax.ua/Cottage-For-Sale-Kyiv-Kyiv_116004009-2?Lang=ru-UA'))

temp_title = new_page.css('title').text.strip

def realty_type_calc title
  if title.include? 'Продажа'
    return 'Продажа'
  elsif title.include? 'Аренда'
    return 'Аренда'
  else
    return 'Unnown'
  end
end

def property_type_calc title
  if title.include?('Квартира') || title.include?('Пентхаус')
    return 'Квартира'
  elsif title.include?('Дом') || title.include?('Коттедж') || title.include?('Таунхаус')
    return 'Дом'
  elsif title.include? 'Земельный'
    return 'Земельный участок'
  else
    return 'Unnown'
  end
end


pageid = new_page.css('[itemprop="productID"]').text.strip
add_time = my_time.inspect
update_time = my_time.inspect
realty_type = realty_type_calc temp_title
property_type = property_type_calc temp_title




puts temp_title
puts '---------------'
puts pageid
puts add_time
puts update_time
puts realty_type
puts property_type

# arr2.each do |list_link|
#   link = list_link
#   curr_page = Nokogiri::HTML(open('link'))
#
# end