package 'torquebox' do
  version node[:torquebox][:version] if node[:torquebox][:version]
end

template node[:torquebox][:gem_wrapper] do
  mode 0755
  source 'gem_wrapper'
  owner node[:torquebox][:user]
  group node[:torquebox][:group]
  variables(
    :torquebox_user => node[:torquebox][:user]
  )
end

directory node[:torquebox][:app_repo] do
  owner node[:torquebox][:user]
  group node[:torquebox][:group]
  mode 0755
  action :create
end

group 'torquebox' do
  members [ node[:vagrant][:config][:ssh][:username] ]
  append true
  action :modify
end if node[:vagrant]

service 'torquebox' do
  action [ :enable, :start ]
end
