puts "Как вас зовут?"
name = gets.chomp
puts "Какой у вас рост?"
growth = gets.chomp

weight = (growth.to_i - 110) * 1.15
puts "#{name}, рассчитан идеальный вес для вашего роста: #{weight}"

if weight < 0
	puts "Ваш вес уже оптимальный"
end