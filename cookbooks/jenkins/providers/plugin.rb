action :add do
  plugins_path = "#{node[:jenkins][:home]}/plugins"
  directory plugins_path do
    owner node[:jenkins][:user]
    group node[:jenkins][:group]
    mode 0755
    action :create
    recursive true
  end
  remote_file "#{plugins_path}/#{new_resource.name}.hpi" do
    source "http://updates.jenkins-ci.org/latest/#{new_resource.name}.hpi"
    mode 0644
    owner node[:jenkins][:user]
    group node[:jenkins][:group]
    action :create_if_missing
    # http://tickets.opscode.com/browse/CHEF-2404 :-(
    #notifies :restart, "service[jenkins]", :delayed
  end
end
