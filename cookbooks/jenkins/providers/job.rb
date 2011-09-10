action :add do

  jenkins_tool new_resource.tool if new_resource.tool
  new_resource.tools.each do |tool|
    jenkins_tool tool
  end

  jenkins_plugin new_resource.plugin if new_resource.plugin
  new_resource.plugins.each do |plugin|
    jenkins_plugin plugin
  end

  project_name = new_resource.cookbook_name
  job_name = "#{project_name}-#{new_resource.name}"
  job_path = "#{node[:jenkins][:home]}/jobs/#{job_name}"
  job_file = "#{new_resource.name}.xml"
  project_path = "#{node[:overbox][:projects_path]}/#{project_name}"

  directory job_path do
    owner node[:jenkins][:user]
    group node[:jenkins][:group]
    mode 0755
    action :create
    recursive true
  end
  
  template "#{job_path}/config.xml" do
    source job_file
    mode 0644
    owner node[:jenkins][:user]
    group node[:jenkins][:group]
    action :create_if_missing
    variables(
      :project_name => project_name,
      :project_path => project_path,
      :job_name     => job_name,
      :job_path     => job_path,
      :job_file     => job_file
    )
    # http://tickets.opscode.com/browse/CHEF-2404 :-(
    #notifies :restart, "service[#{node[:jenkins][:service]}]", :delayed
  end

end
