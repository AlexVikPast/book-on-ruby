module Animal; end

Animal.const_set("COUNT_ANIMAL", 2)
puts Animal::COUNT_ANIMAL # ===> 2

class Dog; end
Dog.const_set("AGE", 5)
puts Dog::AGE # ===> 5

Kernel.const_set("HELLO", "world")
puts HELLO # ===> world