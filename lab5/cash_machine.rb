# Class that implements ATM logic
class CashMachine
  attr_reader :balance

  def initialize(filename = 'balance.txt')
    @filename = filename
    @balance = if File.exist?(filename)
                 File.read(filename).to_f
               else
                 File.write(filename, 100.0, mode: 'w').to_f
               end
  end

  def deposit(amount)
    if amount > 0.0
      @balance += amount
      File.write(@filename, @balance, mode: 'w')
      true
    else
      false
    end
  end

  def withdraw(amount)
    if amount <= @balance
      @balance -= amount
      File.write(@filename, @balance, mode: 'w')
      true
    else
      false
    end
  end
end
