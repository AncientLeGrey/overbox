include TorqueBox::Environment

action :add do

  name = ::File.basename(new_resource.name)
  root = find_project(new_resource.root)||find_project(name)

  torquebox_bundle root if ::File.exists?("#{root}/Gemfile")

  template knob_file(name) do
    mode 0775
    source 'knob.yml'
    cookbook 'torquebox'
    owner node[:torquebox][:user]
    group node[:torquebox][:group]
    variables(
      :root         => root,
      :context      => (new_resource.context||name),
      :env          => new_resource.env,
      :static       => new_resource.static,
      :ruby_version => new_resource.ruby_version,
      :environment  => new_resource.environment
    )
  end

end

action :remove do

  name = File.basename(new_resource.name)
  ::File.delete(knob_file(name))
  
end
