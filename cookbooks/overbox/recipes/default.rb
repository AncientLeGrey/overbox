node[:overbox][:yum_repos].each do |name, url|
  yum_repo name do
    baseurl url
  end
end

template '/home/vagrant/.bashrc' do
  source 'bashrc'
  owner 'vagrant'
  group 'vagrant'
  variables(
    :project_path => node[:overbox][:projects_path]
  )
  mode 0644
end

require_recipe 'overbox::unselinux' unless node[:overbox][:selinux]
