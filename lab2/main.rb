def foo(word)
  if word[-2..] == 'CS'
    2**word.size
  else
    word.reverse
  end
end
