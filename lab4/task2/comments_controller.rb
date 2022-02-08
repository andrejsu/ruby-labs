require_relative 'controller'

class CommentsController < Controller
  def show
    id = validate_element do
      validate_input { print 'Enter the number of the comment you want to display \ q to exit: ' }
    end
    return if id.nil?

    puts "#{id}. #{@elements[id - 1]}"
  end

  def create
    puts 'Enter the text of the comment \ q to exit: '
    text = gets.chomp
    return if text.downcase == 'q'

    @elements.push(text)
    id = @elements.length
    puts "Comment: #{text}\nid: #{id}"
    { id => @elements[id - 1] }
  end

  def update
    id = validate_element do
      validate_input { print 'Enter the number of the comment you want to update \ q to exit: ' }
    end
    return if id.nil?

    puts 'Enter new text of the comment \ q to exit: '
    text = gets.chomp
    return if text.downcase == 'q'

    @elements[id - 1] = text
    puts "#{id}. #{@elements[id - 1]}"
    { id => @elements[id - 1] }
  end

  def destroy
    id = validate_element do
      validate_input { print 'Enter the number of the comment you want to delete \ q to exit: ' }
    end
    return if id.nil?

    @elements.delete_at(id - 1)
    puts "Comment №#{id} successfully deleted"
    @elements[id - 1]
  end
end
