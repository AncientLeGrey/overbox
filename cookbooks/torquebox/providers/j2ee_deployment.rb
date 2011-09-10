action :add do

  type = ::File.extname(new_resource.name)
  name = ::File.basename(new_resource.name, type)
  source = new_resource.source || new_resource.name
  context = new_resource.context || name
  location = "#{node[:torquebox][:app_repo]}/#{context}#{type}"
  target = "#{node[:torquebox][:deploy_dir]}/#{context}#{type}"

  unless new_resource.environment.empty? then
    env_file = "#{name}.env"
    template "#{node[:torquebox][:conf_dir]}/#{env_file}" do
      source 'j2ee.env'
      owner node[:torquebox][:user]
      group node[:torquebox][:group]
      cookbook 'torquebox'
      mode 0755
      variables(
        :environment => new_resource.environment
      )
      # http://tickets.opscode.com/browse/CHEF-2404 :-(
      # notifies :restart, "service[#{node[:torquebox][:service]}]", :delayed
    end
  end

  remote_file location do
    source source
    mode 0755
    owner node[:torquebox][:user]
    group node[:torquebox][:group]
    action :create_if_missing
  end
  
  link target do
    to location
    owner node[:torquebox][:user]
    group node[:torquebox][:group]
    not_if "test -L #{target}"
  end

end
