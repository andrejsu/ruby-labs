# Class that implements ATM logic
class CashMachine
  def initialize(filename = 'balance.txt')
    @filename = filename
    @balance = if File.exist?(filename)
                 File.read(filename).to_f
               else
                 File.write(filename, 100.0, mode: 'w').to_f
               end
  end

  def deposit
    balance
    print 'Enter deposit amount: '
    amount = gets.to_f
    if amount > 0.0
      @balance += amount
      balance
    else
      puts 'Amount entered incorrectly! Deposit cannot be negative'
    end
  end

  def withdraw
    balance
    print 'Enter deposit amount: '
    amount = gets.to_f
    if amount <= @balance
      @balance -= amount
      balance
    else
      puts 'Amount entered incorrectly! Withdrawal cannot exceed balance'
    end
  end

  def balance
    puts "Current balance: #{@balance}"
  end

  def init
    print "D - Deposit \nW - Withdraw \nB - Balance \nQ - Quit\nEnter one of the commands: "
    loop do
      input_command = gets.chomp.downcase
      case input_command
      when 'd'
        deposit
      when 'w'
        withdraw
      when 'b'
        balance
      when 'q'
        File.write(@filename, @balance)
        break
      else
        puts "Command #{input_command} does not exist, please enter one of the following. "
      end
      print "\nD - Deposit \nW - Withdraw \nB - Balance \nQ - Quit\nEnter one of the commands: "
    end
  end
end
