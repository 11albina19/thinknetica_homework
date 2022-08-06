hash_product = {}

while true
puts 'Введите название товара: '
name_ = gets.chomp.to_s
if name_ == 'стоп'
  break
end
puts 'Введите цену за единицу: '
price  = gets.chomp.to_i
puts 'Введите количество купленного товара: '
amount   = gets.chomp.to_f
hash_date = {'price':price, 'amount':amount}
hash_product[name_:] = hash_date
end

puts hash_product