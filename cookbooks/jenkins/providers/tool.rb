action :add do

  name = new_resource.name.capitalize

  cookbook_file "#{node[:jenkins][:home]}/hudson.tasks.#{name}.xml" do
    cookbook 'jenkins'
    source "tasks/hudson.tasks.#{name}.xml"
    mode 0644
    owner node[:jenkins][:user]
    group node[:jenkins][:group]
    action :create_if_missing
  end

end
