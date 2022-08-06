hash_product = {}
sum_total = 0
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
hash_date = {'price':price, 'amount':amount, 'summ': price*amount}
sum_total = sum_total + price*amount
hash_product[name_:] = hash_date
end

puts hash_product
puts 'Общая сумма всех покупок в корзине: ' + sum_total.to_s