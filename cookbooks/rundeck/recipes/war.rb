require_recipe 'torquebox'

#directory "#{node[:rundeck][:home]}" do
#  owner node[:rundeck][:user]
#  group node[:rundeck][:group]
#  mode 0755
#  action :create
#end

torquebox_j2ee_deployment node[:rundeck][:war]
