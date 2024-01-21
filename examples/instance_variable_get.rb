class A
  def initialize(a)
    @a = a
  end
end

obj = A.new("1")
puts obj.@a
puts obj.instance_variable_get("@a")
