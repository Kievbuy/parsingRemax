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
address_array = new_page.css('.key-address').text.strip.split

address_array.delete('-')

address_array << '25'

puts address_array
puts address_array.size

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

# Разделение строки адреса на отдельные данные
num_text_arr = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9']
address_city = address_array[0]

if address_array.size > 2
  if num_text_arr[0..9] != address_array[1][0] && num_text_arr[0..9] == address_array[2][0]
    address_city << ' ' << address_array[1]
  end
end

address_street = ''
if address_array.size > 2
  if num_text_arr[0..9] != address_array[1][0] && num_text_arr[0..9] != address_array[2][0]
    address_street << address_array[1]
  else
    address_street << address_array[2]
  end
else
  address_street << address_array[1]
end

address_house = ''
if num_text_arr.include?(address_array[1][0])
  address_house << address_array[1]
elsif address_array.size > 2 && num_text_arr.include?(address_array[2][0])
  address_house << address_array[2]
end

# ========== rooms_count  ==============

rooms = new_page.css('//*[@id="LeftColumn"]/div/div/div[1]/div[2]/div[1]/div[1]/div/div[2]')
puts rooms



#========================================
#========================================

pageid = new_page.css('[itemprop="productID"]').text.strip  # id
add_time = my_time.inspect                                  # <add_time>
update_time = my_time.inspect                               # <update_time>
realty_type = realty_type_calc temp_title              # <contract_type>
property_type = property_type_calc temp_title          # <realty_type>
region = ''                                                 # <region>
rajon = ''                                                  # <rajon>
city = address_city                                         # <city>
district = ''                                               # <district>
microdistrict = ''                                          # <microdistrict>
street = address_street                                     # <street>
house = address_house                                       # <house>
room_count =




puts temp_title
puts address_array
puts '---------------'
puts pageid
puts add_time
puts update_time
puts realty_type
puts property_type
puts city
puts street
puts house

# arr2.each do |list_link|
#   link = list_link
#   curr_page = Nokogiri::HTML(open('link'))
#
# end