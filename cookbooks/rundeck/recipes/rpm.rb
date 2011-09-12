yum_repo 'rundeck' do
  baseurl node[:rundeck][:yum_repo]
end

package 'rundeck'

group 'admin' do
  members ['rundeck']
  append true
  action :modify
end

group 'rvm' do
  members ['rundeck']
  append true
  action :modify
end

rundeck_members = ['root', 'vagrant']

if node[:torquebox][:components].include?(:server) then
  group node[:torquebox][:group] do
    members ['rundeck']
    append true
    action :modify
  end
  rundeck_members << node[:torquebox][:user]
end if node[:torquebox]

group 'rundeck' do
  members rundeck_members
  append true
  action :modify
end

template '/home/rundeck/.bashrc' do
  source 'bashrc'
  owner 'rundeck'
  group 'rundeck'
  variables(
    :project_path => node[:overbox][:projects_path]
  )
  mode 0644
end

cookbook_file '/etc/rundeck/realm.properties' do
  source 'realm.properties'
  mode 0644
end

cookbook_file '/etc/rundeck/jetty-ajp.xml' do
  source 'jetty-ajp.xml'
  mode 0644
end

service 'rundeckd' do
  action [ :enable, :start ]
end
