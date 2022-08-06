number = gets.chomp.to_i
month  = gets.chomp.to_i
year   = gets.chomp.to_i

months = {'January' => 31, 'February' => 28, 'March' => 31, 'April' => 30, 'May' => 31, 'June' => 30, 
'July' => 31, 'August' => 31, 'September' => 30, 'October' => 31, 'November' => 30, 'December' => 31}

arr = months.values

i = 1;
serial_number = 0;

if year % 4 == 0
if year % 100 == 0
if year % 400 == 0 
leap_year = true
else
leap_year = false
end
else
leap_year = true
end
else
leap_year = false
end



while i < month 
serial_number = serial_number + arr[i-1]
if i == 2 && leap_year == true
serial_number = serial_number + 1
end
i += i
end

serial_number = serial_number + number

puts 'Порядковый номер даты: ' + serial_number.to_s