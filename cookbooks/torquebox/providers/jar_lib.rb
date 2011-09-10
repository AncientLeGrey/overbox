action :add do

  remote_file "#{node[:jboss][:lib_dir]}/#{new_resource.name}" do
    source new_resource.source
    mode 0755
    owner node[:torquebox][:user]
    group node[:torquebox][:group]
    action :create_if_missing
    # http://tickets.opscode.com/browse/CHEF-2404 :-(
    # notifies :restart, "service[#{node[:jenkins][:service]}]", :delayed
  end

end
