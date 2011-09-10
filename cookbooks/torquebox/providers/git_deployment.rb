action :add do

  name = ::File.basename(new_resource.name)
  root = new_resource.root || "#{node[:torquebox][:app_repo]}/#{name}"

  git root do
    repository new_resource.name
    reference new_resource.revision
    user node[:torquebox][:user]
    group node[:torquebox][:group]
    action :sync
  end

  torquebox_knob_deployment ::File.basename(name, '.git') do
    root root
    env new_resource.env
    context new_resource.context || ::File.basename(name, '.git')
    static new_resource.static
    environment new_resource.environment
  end

end

action :remove do

  name = ::File.basename(new_resource.name)
  project_path = "/home/#{node[:torquebox][:user]}/#{name}"

  torquebox_deploy_knob name do
    action :remove
  end

  directory project_path do
    action :delete
    recursive true
  end

end
