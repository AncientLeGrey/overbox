require_recipe "jenkins::#{node[:jenkins][:deployment]}"

directory "#{node[:jenkins][:home]}" do
  owner node[:jenkins][:user]
  group node[:jenkins][:group]
  mode 0755
  action :create
end

directory "#{node[:jenkins][:home]}/jobs" do
  owner node[:jenkins][:user]
  group node[:jenkins][:group]
  mode 0755
  action :create
end

node[:jenkins][:plugins].each do |plugin|
  jenkins_plugin plugin
end
