class Animal
  attr_accessor :name

  def initialize(name)
    @name = name
  end
end

Animal.module_eval do
  def my_name
    puts "Привет, меня зовут, #{name}."
  end
end

animal = Animal.new("Tom")
animal.my_name # ===> Привет, меня зовут, Tom.