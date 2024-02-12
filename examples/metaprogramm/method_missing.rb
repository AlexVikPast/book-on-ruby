class Animal
  def method_missing(method_name, *args)
    puts "Метод #{method_name} не определен с аргументами: #{args}"
  end
end

animal = Animal.new

animal.my_name # ===> Метод my_name не определен с аргументами: []
animal.set_name_and_age("Tome", 10) # ===> Метод set_name_and_age не определен с аргументами: ["Tome", 10]
