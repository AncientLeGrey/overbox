require_recipe 'torquebox'

torquebox_j2ee_deployment node[:jenkins][:war] do
  environment(
    :JENKINS_HOME => node[:jenkins][:home]
  )
end
