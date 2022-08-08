fibonacci = [0, 1]
index     = 2
x         = 0

while x < 100 
  f1 = fibonacci [index - 1].to_i
  f2 = fibonacci [index - 2].to_i
  x  = f1 + f2 
  if x < 100
    fibonacci << x
    index     = index + 1
  end
end

print fibonacci