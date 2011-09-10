def initialize(*args)
  super
  @action = :add
end

actions :add

attribute :name, :regex => /^(maven|ant)$/, :name_attribute => true