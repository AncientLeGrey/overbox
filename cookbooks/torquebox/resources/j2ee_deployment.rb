def initialize(*args)
  super
  @action = :add
end

actions :add

attribute :name, :kind_of => String, :name_attribute => true
attribute :source, :kind_of => String, :default => nil
attribute :context, :kind_of => String, :default => nil
attribute :environment, :kind_of => Hash, :default => {}
