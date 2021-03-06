def initialize(*args)
  super
  @action = :add
end

actions :add, :remove

attribute :name, :kind_of => String, :name_attribute => true
attribute :revision, :kind_of => String, :default => 'master'
attribute :root, :kind_of => String, :default => nil
attribute :env, :regex => /^(development|test|production)$/, :default => 'development'
attribute :context, :kind_of => String, :default => nil
attribute :static, :kind_of => String, :default => nil
attribute :environment, :kind_of => Hash, :default => {}
