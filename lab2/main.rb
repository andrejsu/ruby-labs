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
