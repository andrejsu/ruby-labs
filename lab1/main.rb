def greeting
  print 'Please, enter your name: '
  first_name = gets.chomp
  print 'Enter your last name: '
  second_name = gets.chomp
  print 'Enter your age: '
  age = gets.to_i

  output_string = if age < 18
                    "Привет, #{first_name} #{second_name}. Тебе меньше 18 лет, " \
                      'но начать учиться программировать никогда не рано.'
                  else
                    "Привет, #{first_name} #{second_name}. Самое время заняться делом!"
                  end

  puts output_string
  output_string
end

def foobar(first_number, second_number)
  puts "First number: #{first_number}, second number: #{second_number}"
  output = if first_number == 20 || second_number == 20
             second_number.to_i
           else
             first_number + second_number
           end

  puts "Result: #{output}"
  output
end
