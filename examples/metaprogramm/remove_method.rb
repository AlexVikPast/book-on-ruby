class Animal
  def hello
    puts "I'm animal"
  end
end

class Cat < Animal
  def hello
    puts "I'm cat"
  end
end

a = Cat.new
a.hello # ===> I'm cat

Cat.remove_method :hello

a.hello # ===> I'm animal

Animal.remove_method :hello
a.hello # ===> undefined method `hello' for