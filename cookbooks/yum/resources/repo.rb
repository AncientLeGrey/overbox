def initialize(*args)
  super
  @action = :add
end

actions :add, :remove, :fetch

attribute :name, :kind_of => String, :name_attribute => true
attribute :baseurl, :kind_of => String
attribute :source, :kind_of => String
attribute :enabled, :default => 1
attribute :gpgcheck, :default => 0
attribute :priority, :default => 1
