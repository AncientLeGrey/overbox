include TorqueBox::Environment

action :install do
  bundle(:install, find_project(new_resource.name))
end

action :update do
  bundle(:update, find_project(new_resource.name))
end

action :package do
  bundle(:package, find_project(new_resource.name))
end
