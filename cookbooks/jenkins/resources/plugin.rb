def initialize(*args)
  super
  @action = :add
end

actions :add

attribute :name, :kind_of => String, :name_attribute => true
