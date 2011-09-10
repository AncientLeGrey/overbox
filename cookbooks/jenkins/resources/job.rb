def initialize(*args)
  super
  @action = :add
end

actions :add

attribute :name, :kind_of => String, :name_attribute => true
attribute :plugins, :kind_of => Array, :default => []
attribute :plugin, :kind_of => String
attribute :tools, :kind_of => Array, :default => []
attribute :tool, :kind_of => String
attribute :variables, :kind_of => Hash, :default => {}
