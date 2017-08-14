a = 'Новые Петровцы 25 Киевская область'.strip.split
puts a[1][0]
puts '----------'
num_text_arr = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9']
address_city = a[0]

  if num_text_arr[0..9].include?(a[1][0])
    address_city
  elsif a.size > 2 && num_text_arr[0..9].include?(a[2][0])
    address_city << ' ' << a[1]
  end


puts address_city