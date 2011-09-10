require_recipe 'java6'

yum_repo 'jenkins' do
  baseurl 'http://pkg.jenkins-ci.org/redhat'
end

package 'jenkins' do
  version node[:jenkins][:version] unless node[:jenkins][:version] == 'latest'
end

template '/etc/sysconfig/jenkins' do
  source 'sysconfig'
  mode 0600
  action :create_if_missing
  variables(
    :jenkins_home => node[:jenkins][:home],
    :jenkins_port => node[:jenkins][:port],
    :jenkins_ajp_port => node[:jenkins][:ajp_port]
  )
end

group 'admin' do
  members [node[:jenkins][:user]]
  append true
  action :modify
end

group 'rvm' do
  members [node[:jenkins][:user]]
  append true
  action :modify
end

service node[:jenkins][:service] do
  action [ :enable, :start ]
end
