module Resource
  def connection(routes)
    if routes.nil?
      puts "No route matches for #{self}"
      return
    end

    loop do
      print 'Choose verb to interact with resources (GET/POST/PUT/DELETE) / q to exit: '
      verb = gets.chomp.upcase
      break if verb == 'Q'

      if verb == 'GET'
        begin
          print 'Choose action (index/show) / q to exit: '
          action = gets.chomp.downcase
          break if action == 'q'

          routes[verb][action].call

          next
        rescue NoMethodError
          puts 'There is no such command. Use one of the index/show'
          retry
        end
      end

      routes[verb].call
    rescue NoMethodError
      puts 'There is no such command. Use one of the GET/POST/PUT/DELETE'
      retry
    end
  end
end
