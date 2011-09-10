def initialize(*args)
  super
  @action = :install
end

actions :install, :update, :package

attribute :name, :kind_of => String, :name_attribute => true
