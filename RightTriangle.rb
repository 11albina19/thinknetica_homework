puts "Введите 1-ую сторону треугольника:"
a = gets.chomp.to_i
puts "Введите 2-ую сторону треугольника:"
b = gets.chomp.to_i
puts "Введите 3-ую сторону треугольника:"
c = gets.chomp.to_i

if a == b && b == c 
	puts "Треугольник равнобедренный и равносторонний"
elsif a == b || b == c || c == a 
	puts "Треугольник равнобедренный"
elsif a*a == b*b + c*c || b*b==a*a+c*c || c*c==b*b+a*a
   puts "Треугольник прямоугольный"
end
