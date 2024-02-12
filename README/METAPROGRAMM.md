# Metaprogramm Programming with Ruby by AlexVikPast

Данный документ расскажет о мощной части метапрограммирования языка Ruby

## Оглавление
* [Введение](#введение)
* [Теория](#теория)
* [Функциональное программирование в Ruby](#функциональное-программирование-в-Ruby)
* [Манипулирование значениями переменных, удаление переменных](#манипулирование-значениями-переменных-удаление-переменных)
  * [instance_variable_get](#instance_variable_get)
  * [instance_variable_set](#instance_variable_set)
  * [remove_instance_variable](#remove_instance_variable)
  * [class_variable_get](#class_variable_get)
  * [class_variable_set](#class_variable_set)
  * [remove_class_variable](#remove_class_variable)
* [Манипулирование значениями констант, удаление констант](#манипулирование-значениями-констант-удаление-констант)
  * [const_get](#const_get)
  * [const_set](#const_set)
  * [remove_const](#remove_const)
* [Добавление/удаление методов](#добавление/удаление-методов)  
  * [define_method](#define_method)
  * [remove_method](#remove_method)
* [Запуск динамически генерируемого кода](#Запуск-динамически-генерируемого-кода)
  * [send](#send)
  * [instance_eval](#instance_eval)
  * [module_eval](#module_eval)
  * [eval](#eval)
  * [method_missing](#method_missing)

## Введение
## Теория
## Функциональное программирование в Ruby
## Манипулирование значениями переменных, удаление переменных
### instance_variable_get

Как на говорит [документация](https://apidock.com/ruby/Object/instance_variable_get)

> Возвращает значение заданной переменной экземпляра или nil, если переменная экземпляра не установлена.

Тут стоит добавить что значение мы получаем непосредственно по имени переменной, это может быть либо строка либо символ.
Данный метод удобно подходит для создания "getter method".

```ruby
class Animal
  def initialize(age)
    @age = age
  end
end

animal = Animal.new(5)
puts animal.age # ===> syntax error, unexpected instance variable
puts animal.instance_variable_get("@age") # ===> 5
```

Как мы видим из [примера](https://github.com/AlexVikPast/book-on-ruby/blob/main/examples/metaprogramm/instance_variable_get.rb) класс без "getter method" вызывает ошибку при обращении к инстанс переменной, но "instance_variable_get" легко с данной задачей справляется.

### instance_variable_set
Снова обратимся к [документации](https://apidock.com/ruby/Object/instance_variable_set)
> Устанавливает переменную экземпляра, через ее символьное обозначение, для данного объекта, хотя строка тоже подойдет.

Данный метод удобно подходит для создания "setter method".

```ruby
class Animal
  def initialize(age)
    @age = age
  end

  def age
    @age
  end
end

animal = Animal.new(10)
puts animal.age # ===> 10
animal.age = 15 # ===> undefined method 'age='

animal.instance_variable_set("@age", 15)
puts animal.age # ===> 15

animal.instance_variable_set(:@age, 20)
puts animal.age # ===> 20
```

Как видно из [примера](https://github.com/AlexVikPast/book-on-ruby/blob/main/examples/metaprogramm/instance_variable_set.rb) без явного метода устанавливающего значения для инстанс переменной или "instance_variable_set" получаем ошибку.

### remove_instance_variable
Что нам говорит [документация?](https://apidock.com/ruby/Object/remove_instance_variable)

> Удаляет именованную переменную экземпляра из объекта obj, возвращая значение этой переменной.

Добавим в наш базовый класс стандартные getter - setter методы.

```ruby
class Animal
  def initialize(age)
    @age = age
  end

  def age=(age)
    @age = age
  end

  def age
    @age
  end

  def remove_age
    remove_instance_variable(:@age)
  end
end

animal = Animal.new(5) 
puts animal.age # ===> 5

animal.age = 10
puts animal.age # ===> 10

puts animal.remove_instance_variable(:@age) # ===> 10
puts animal.age # ===> nil

animal.age = 15
puts animal.remove_age # ===> 15
```

Как мы [видим](https://github.com/AlexVikPast/book-on-ruby/blob/main/examples/metaprogramm/remove_instance_variable.rb) методы можно с легкостью вызывать с объекта класса или внутри класса.

### class_variable_get
В документации [пишут](https://apidock.com/ruby/Module/class_variable_get)

> Возвращает значение заданной переменной класса (или выдает исключение NameError).

Ссылка на неинициализированную переменную класса вызывает ошибку. Переменные класса распределяются между потомками класса или модуля, в которых определены переменные класса.

Добавим счетщик созданных животных через переменную класса.

```ruby
class Animal

  @@count_animal = 0

  def initialize(age)
    @@count_animal += 1
    @age = age
  end

  def age=(age)
    @age = age
  end

  def age
    @age
  end

  def population
    @@count_animal
  end
end

cat = Animal.new(5)
puts cat.class_variable_get(:@@count_animal) # ===> undefined method `class_variable_get'
puts Animal.class_variable_get(:@@count_animal) # ===> 1
puts cat.population # ===> 1

dog = Animal.new(10)
puts dog.population # ===> 2

puts cat.population # ===> 2
```

Теперь каждый знает сколько всего животных было создано через класс [Animal](https://github.com/AlexVikPast/book-on-ruby/blob/main/examples/metaprogramm/class_variable_get.rb). Стоит обратить внимание что метод вызывается от класса, попытка вызова данного метода от объекта приведет к ошибке метода.

### class_variable_set

В документации [пишут](https://apidock.com/ruby/Module/class_variable_set)

> Устанавливает переменную класса, названную символом, для данного объекта.

Так же добавим счетщик созданных животных через переменную класса, но в этот раз мы его заведем через метод класса.

```ruby
class Animal

  @@count_animal = 0

  def initialize(age)
    @age = age
  end

  def age=(age)
    @age = age
  end

  def age
    @age
  end

  def population
    @@count_animal
  end
end

cat = Animal.new(5)
Animal.class_variable_set(:@@count_animal, cat.population + 1)
puts cat.population # ===> 1

dog = Animal.new(10)
dog.class.class_variable_set(:@@count_animal, dog.population + 1)
puts dog.population # ===> 2

```

Функционал [класса](https://github.com/AlexVikPast/book-on-ruby/blob/main/examples/metaprogramm/class_variable_set.rb) остался практически таким же.

### remove_class_variable

Пришло время избавиться от [переменных класса](https://apidock.com/ruby/Module/remove_class_variable) которые мы добавили ранее.

> Удаляет определение символа, возвращая значение этой константы.

Функционал схож с [remove_instance_variable](https://apidock.com/ruby/Object/remove_instance_variable), только удаляет переменные класса.

```RUBY
class Animal
  @@count_animal = 0

  def initialize(age)
    @@count_animal += 1
    @age = age
  end

  def age=(age)
    @age = age
  end

  def age
    @age
  end

  def population
    @@count_animal
  end
end

cat = Animal.new(5)
puts cat.population # ===> 1

dog = Animal.new(10)
puts dog.population # ===> 2

Animal.remove_class_variable(:@@count_animal)
puts cat.population # ===> `population': uninitialized class variable @@count_animal in Animal
```

После [удаления](https://github.com/AlexVikPast/book-on-ruby/blob/main/examples/metaprogramm/remove_class_variable.rb) @@count_animal объекты класса теряют доступ к методу "population" введу отсутствия переменной класса.

## Манипулирование значениями констант, удаление констант
### const_get

На первый взгляд [документация](https://apidock.com/ruby/Module/const_get) кажется чуть чуть запутанной и сложной. Давайте рассмотрим более простой и уже привычный пример.

> Проверяет наличие константы с заданным именем в mod. Если установлено наследование, поиск также будет искать предков (и Object, если mod является Module).

```RUBY
class Animal
  def initialize(age)
    @age = age
  end
end

klass_name = "animal"
Klass = Object.const_get(klass_name.capitalize.to_sym)
animal = Klass.new(5)
puts animal.inspect # ===> #<Animal:0x000000014c107ed8 @age=5>

Dog = Object.const_get(:Dog) # ===> `const_get': uninitialized constant Dog (NameError)
```
Как [видим](https://github.com/AlexVikPast/book-on-ruby/blob/main/examples/metaprogramm/const_get.rb) мы можем "на лету" получить доступ к классу через изначально его строковое предствление.
При попытке получить доступ несуществующему классу получим ошибку.

### const_set

Как и прошлый раз [документация](https://apidock.com/ruby/Module/const_set) скудна, но есть комментарии пользователей.

> Устанавливает именованную константу для данного объекта, возвращая этот объект.

Чтобы константа стала самостоятельной, без привязки к каким - либо классам или модулям необходимо ее завести в module Kernel. Так как модуль Kernel включен в класс Object, поэтому его методы доступны в каждом объекте Ruby.

Для [иного](https://github.com/AlexVikPast/book-on-ruby/blob/main/examples/metaprogramm/const_set.rb) установления констант указывает к какому классу или модулю производим добавление.

```RUBY
module Animal; end

Animal.const_set("COUNT_ANIMAL", 2)
puts Animal::COUNT_ANIMAL # ===> 2

class Dog; end
Dog.const_set("AGE", 5)
puts Dog::AGE # ===> 5

Kernel.const_set("HELLO", "world")
puts HELLO # ===> world
```

### remove_const

На этот раз [документация](https://apidock.com/ruby/Module/remove_const) не содержит ни каких примеров =).

> Удаляет определение данной константы, возвращая предыдущее значение этой константы.

Давайте постараемся разобраться.

```RUBY
class Animal
  AGE = 5
  COUNT_ANIMAL = 10

  def self.remove_const_call
    remove_const(:AGE)
  end
end

puts Animal::COUNT_ANIMAL
Animal.send(:remove_const, :COUNT_ANIMAL)

puts Animal::COUNT_ANIMAL # ===> uninitialized constant Animal::COUNT_ANIMAL

puts Animal::AGE
Animal.remove_const_call
puts Animal::AGE # ===> uninitialized constant Animal::AGE
```

Вся ["соль"](https://github.com/AlexVikPast/book-on-ruby/blob/main/examples/metaprogramm/remove_const.rb) вызова данного метода заключается в хитрости вызова, если вызывать его от класса, то необходимо прибегнуть к методу ["send"](#send) - но о нем мы поговорим позднее, и вызове через метода класса, с явным указание константы в качестве аргумента. 

## Добавление/удаление методов
### define_method

[Define_method](https://apidock.com/ruby/Module/define_method) может на лету добавлять в наши классы новые методы.

> Определяет метод экземпляра в получателе.

```RUBY
class Animal
  attr_accessor :name

  def initialize(name)
    @name = name
  end
end

Animal.define_method(:voice) { puts 'У меня появился голос' }
Animal.define_method(:my_name) { puts send(:name) }

a = Animal.new('Tom')
a.voice
puts a.name
a.my_name
```

Изначально наш [класс](https://github.com/AlexVikPast/book-on-ruby/blob/main/examples/metaprogramm/define_method.rb) только умеет только запоминать свое имя и возвращать его.
Первый вызов define_method - на лету добавляет к классу метод с вызовом блока кода.
Второй вызов define_method - добавляем метод alias для вызова стандартного getter метода.


### remove_method

[Remove_method](https://apidock.com/ruby/Module/remove_method) может на лету удалить в наши классы методы.

> Удаляет метод, обозначенный символом, из текущего класса.

```RUBY
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
```

[remove_method](https://github.com/AlexVikPast/book-on-ruby/blob/main/examples/metaprogramm/remove_method.rb) при вызове от класса, все объекты класса теряют данный метод. Тут стоит уделить особое внимание что поиск метода переходит на уровень выше и если был найден в родительском классе берет его от туда.

undef_method - удаляем метод во всем дереве наследовании классов.

## Запуск динамически генерируемого кода 
### send

[Send](https://apidock.com/ruby/Object/send) самый мощный, на мой взгляд, элемент метапрограммирования.

> Вызывает метод, определенный символом, передавая ему все указанные аргументы.

```RUBY
class Animal
  attr_accessor :age

  def initialize(age)
    @age = age
  end
end

animal = Animal.new(5)
p animal.send("age") # ===> 5
animal.send("age=", 4) 

p animal.send("age") # ===> 4
```

В данном случае при помощи [send](https://github.com/AlexVikPast/book-on-ruby/blob/main/examples/metaprogramm/send.rb) мы реализуем getter/setter методы.

### instance_eval

[instance_eval](https://apidock.com/ruby/Object/instance_eval)

> Оценивает строку, содержащую исходный код Ruby или заданный блок, в контексте получателя.

```RUBY
class Animal
  attr_accessor :name

  def initialize(name)
    @name = name
  end
end

person = Animal.new("Tom")
person.instance_eval do
  puts "Привет, меня зовут #{name}!" # ===> Привет, меня зовут Tom!
end
```

В [блоке](https://github.com/AlexVikPast/book-on-ruby/blob/main/examples/metaprogramm/instance_eval.rb) мы используем метод puts для вывода сообщения, которое включает имя объекта animal. И поскольку мы выполняем блок кода в контексте объекта animal, метод name может быть вызван без явного указания объекта.


### module_eval

[module_eval](https://apidock.com/ruby/Module/module_eval) в Ruby позволяет выполнить блок кода в контексте указанного модуля или класса. Это может быть полезно, когда вам нужно определить методы или выполнить другие действия в рамках контекста модуля или класса.

```RUBY
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
```

Опять все дело в контексте выполнения [кода](https://github.com/AlexVikPast/book-on-ruby/blob/main/examples/metaprogramm/module_eval.rb), код выполняется от объекта animal, который получил данный метод через module_eval класса Animal.

### eval

[eval](https://apidock.com/ruby/Kernel/eval) в Ruby позволяет выполнять строку как код.

> Оценивает выражения Ruby в строке.

```RUBY
eval('def say_my_name(name)
  puts "Привет, я кот: " + name + "!"
end')

say_my_name("Tom")
```

Однако следует быть осторожным при использовании [eval](https://github.com/AlexVikPast/book-on-ruby/blob/main/examples/metaprogramm/eval.rb), так как он может представлять потенциальную уязвимость безопасности, особенно если код выполняется из внешних источников. Рекомендуется использовать eval только при необходимости и при обработке известных и доверенных данных.

### method_missing

[method_missing](https://apidock.com/ruby/BasicObject/method_missing) один из самых легких для понимания методов метапрограммирования.

> Вызывается Ruby, когда obj отправляет сообщение, которое он не может обработать.

```RUBY
class Animal
  def method_missing(method_name, *args)
    puts "Метод #{method_name} не определен с аргументами: #{args}"
  end
end

animal = Animal.new

animal.my_name # ===> Метод my_name не определен с аргументами: []
animal.set_name_and_age("Tome", 10) # ===> Метод set_name_and_age не определен с аргументами: ["Tome", 10]
```
Если метода нет, идет ["перехват"](https://github.com/AlexVikPast/book-on-ruby/blob/main/examples/metaprogramm/method_missing.rb) нашим замечательным методом.