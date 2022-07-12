puts "Введите значение a:"
a = gets.chomp.to_i
puts "Введите значение b:"
b = gets.chomp.to_i
puts "Введите значение c:"
c = gets.chomp.to_i

d = b*b - 4*a*c

if d < 0
    puts "Корней нет!"
else
	x1 = (-b + Math.sqrt(d))/(2*a)
	x2 = (-b + Math.sqrt(d))/(2*a)

	puts "X1 = #{x1}, X2 = #{x2}"
end