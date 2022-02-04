def read_file(filename)
  File.open(filename) do |file|
    file.readlines.map { |line| line.strip.chomp }
  end
end

def find_all(lines, id)
  lines.find_all { |line| line.include?(id.to_s) }
end

def id_list(lines)
  is_include = {}
  lines.each do |line|
    is_include[line.split[2]] = false
  end
  is_include
end

def duplicator(input_path, output_path = 'result.txt')
  lines = read_file(input_path)
  id_list = id_list(lines)
  results = []

  loop do
    print 'Enter the age of the students you want to include in the resulting list (to exit, enter -1): '
    begin
      id = Integer gets
    rescue ArgumentError
      print "It's not a number.Try again, enter a number: "
      retry
    end
    break if id == -1

    if id <= 0
      puts 'The entered number cannot be less than or equal to 0. Try again'
      next
    end

    if id_list[id.to_s]
      puts 'These items have already been added to the list. Try again'
    elsif !id_list.key?(id.to_s)
      puts 'There are no elements with this number. Try again'
    else
      id_list[id.to_s] = true
      results << find_all(lines, id)
    end

    if id_list.values.all? true
      puts 'All data has been copied'
      break
    end
  end
  puts results.join("\n")
  File.write(output_path, results.join("\n"), mode: 'w')
end
