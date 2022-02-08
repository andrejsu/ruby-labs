require_relative 'resource'

class Controller
  extend Resource

  def initialize(elements = [])
    @elements = elements
  end

  def index
    @elements.each.with_index do |element, index|
      puts "#{index + 1}. #{element}"
    end
  end

  private

  def validate_input
    loop do
      yield if block_given?

      input = gets.chomp
      break if input.downcase == 'q'
      raise "Oops, you didn't enter anything. Try again" if input.strip.empty?

      id = Integer input
      raise 'The number cannot be less than one. Try again' if id < 1

      return id
    rescue ArgumentError
      puts 'Oops, you entered not a number. Try again'
      retry
    rescue StandardError => e
      puts e.message
      retry
    end
  end

  def validate_element
    id = yield
    unless id.nil?
      raise 'There is no element with this number' if @elements[id - 1].nil?

      id
    end
  rescue StandardError => e
    puts e.message
    retry
  end
end
