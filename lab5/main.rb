require 'socket'
require 'rack'

require_relative 'cash_machine'

server = TCPServer.new('0.0.0.0', 3000)
class App
  def self.call(env)
    req = Rack::Request.new(env)

    cash_machine = CashMachine.new

    case req.path_info
    when '/withdraw'
      begin
        value = Integer req.GET['value']
      rescue ArgumentError, TypeError
        return [402, { 'Content-Type' => 'text/html' }, ['You enter not a number. Request example (/withdraw?value=5)']]
      end

      case cash_machine.withdraw(value)
      when true
        [200, { 'Content-Type' => 'text/html' }, ["You have withdrawn #{value}$"]]
      when false
        [403, { 'Content-Type' => 'text/html' }, ['This value is bigger than your balance!']]
      else
        [402, { 'Content-Type' => 'text/html' }, ['Enter withdraw value']]
      end

    when '/deposit'
      begin
        value = Integer req.GET['value']
      rescue ArgumentError, TypeError
        return [402, { 'Content-Type' => 'text/html' }, ['You enter not a number. Request example (/deposit?value=5)']]
      end

      case cash_machine.deposit(value)
      when true
        [200, { 'Content-Type' => 'text/html' }, ["You deposited #{value}$"]]
      when false
        [403, { 'Content-Type' => 'text/html' }, ['Invalid value, must be higher than zero!']]
      else
        [402, { 'Content-Type' => 'text/html' }, ['Enter deposit value']]
      end

    when '/balance'
      [200, { 'Content-Type' => 'text/html' }, ["Your balance is #{cash_machine.balance}$."]]
    else
      [404, { 'Content-Type' => 'text/html' }, ['This page was not found, try one of the proposed' \
                                                '(withdraw, deposit, balance)!']]
    end
  end
end

while (connection = server.accept)
  request = connection.gets
  method, full_path, http_version = request.split
  path, query_string = full_path.split('?')

  status, headers, body = App.call(
    {
      'REQUEST_METHOD' => method,
      'PATH_INFO' => path,
      'QUERY_STRING' => query_string
    }
  )

  connection.print "#{http_version} #{status} \r\n"
  headers.each do |key, value|
    connection.print("#{key}: #{value}\r\n")
  end

  connection.print "\r\n"

  body.each do |part|
    connection.print(part)
  end

  connection.close
end
