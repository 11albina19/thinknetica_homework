vowel    = ['A', 'E', 'I', 'O', 'U', 'Y']
alphabet = ('A'..'Z').to_a
hash     = {}

for index in vowel
  i = alphabet.find_index(index)
  hash[index] = i+1
end

puts hash