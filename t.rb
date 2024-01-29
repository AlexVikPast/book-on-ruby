class Dummy
  @@var = 99
  puts @@var
  remove_class_variable(:@@var)
  p(defined? @@var)
end

