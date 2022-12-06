puts "Какое основание у треугольника?"
a = gets.chomp
puts "Какая высота у треугольника?"
h = gets.chomp

S = a.to_i*h.to_i*1/2
puts "Площадь треугольника: #{S}"