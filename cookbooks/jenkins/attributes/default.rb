default[:jenkins][:deployment] = 'war' # war or rpm
default[:jenkins][:version] = 'latest'

default[:jenkins][:plugins] = [ 'rebuild', 'greenballs' ]
default[:jenkins][:home] = '/var/lib/jenkins'

case node[:jenkins][:deployment]
when 'rpm' then
  default[:jenkins][:user] = 'jenkins'
  default[:jenkins][:group] = 'jenkins'
  default[:jenkins][:port] = 3001
  default[:jenkins][:ajp_port] = -1
  default[:jenkins][:service] = 'jenkins'
when 'war' then
  default[:jenkins][:user] = 'torquebox'
  default[:jenkins][:group] = 'torquebox'
  default[:jenkins][:port] = 8080
  default[:jenkins][:ajp_port] = 8009
  default[:jenkins][:service] = 'torquebox'
  default[:jenkins][:war] = "http://mirrors.jenkins-ci.org/war/#{node[:jenkins][:version]}/jenkins.war"
end
