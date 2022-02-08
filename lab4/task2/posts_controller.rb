require_relative 'controller'

class PostsController < Controller
  def show
    id = validate_element do
      validate_input { print 'Enter the number of the post you want to display \ q to exit: ' }
    end
    return if id.nil?

    puts "#{id}. #{@elements[id - 1]}"
  end

  def create
    puts 'Enter the text of the post \ q to exit: '
    text = gets.chomp
    return if text.downcase == 'q'

    @elements.push(text)
    id = @elements.length
    puts "Post: #{text}\nid: #{id}"
    { id => @elements[id - 1] }
  end

  def update
    id = validate_element do
      validate_input { print 'Enter the number of the post you want to update \ q to exit: ' }
    end
    return if id.nil?

    puts 'Enter new text of the post \ q to exit: '
    text = gets.chomp
    return if text.downcase == 'q'

    @elements[id - 1] = text
    puts "#{id}. #{@elements[id - 1]}"
    { id => @elements[id - 1] }
  end

  def destroy
    id = validate_element do
      validate_input { print 'Enter the number of the post you want to delete \ q to exit: ' }
    end
    return if id.nil?

    @elements.delete_at(id - 1)
    puts "Post №#{id} deleted"
    @elements[id - 1]
  end
end
