# =================== Task 1 ===================
def foo(word)
  if word[-2..] == 'CS'
    2**word.size
  else
    word.reverse
  end
end

def foo_cli
  print 'Please enter any word: '
  input_word = gets.chomp
  foo(input_word)
end

# =================== Task 2 ===================
def add_pokemons(count)
  pokemons = []

  count.times do |i|
    puts "#{i + 1}) Enter pokemon name: "
    name = gets.chomp
    puts 'Enter pokemon color: '
    color = gets.chomp

    pokemons << { name => color }
  end

  pokemons
end

def format_pokemons(array)
  output_string = ''
  array.each do |item|
    item.each { |key, value| output_string << "{ name: '#{key}', color: '#{value}' },\n" }
  end
  '[' << output_string.chop.chop << ']'
end

def validate_int_input
  Integer gets
rescue ArgumentError
  print 'Try again. Enter a number: '
  retry
end

def pokemons_cli
  print 'First, enter how many Pokemon you want to add to the array: '
  count = validate_int_input

  pokemons = add_pokemons(count)
  puts 'Pokemons array:'
  puts format_pokemons(pokemons)
end
