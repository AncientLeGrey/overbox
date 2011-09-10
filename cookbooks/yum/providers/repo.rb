action :add do

  execute 'yum -q makecache' do
    action :nothing
  end

  template "/etc/yum.repos.d/#{new_resource.name}.repo" do
    cookbook 'yum'
    source 'repo.erb'
    mode '0644'
    owner 'root'
    group 'root'
    action :create_if_missing
    variables(
      :name => new_resource.name,
      :baseurl => new_resource.baseurl,
      :enabled => new_resource.enabled,
      :gpgcheck => new_resource.gpgcheck,
      :priority => new_resource.priority
    )
    # http://tickets.opscode.com/browse/CHEF-2404 :-(
    # notifies :run, 'execute[yum -q makecache]', :immediately
  end

end

action :remove do
  file "/etc/yum.repos.d/#{new_resource.name}.repo" do
    action :delete
  end
end

action :fetch do
  remote_file "/etc/yum.repos.d/#{new_resource.name}.repo" do
    source new_resource.source
    mode 0644
    owner 'root'
    group 'root'
    action :create_if_missing
  end
end
