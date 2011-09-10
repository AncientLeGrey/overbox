gem_package "edouard-clarity"

template '/etc/init.d/clarity' do
  source 'clarity.init'
  mode 0755
  #action :create_if_missing
  variables(
    :log_dir => node[:clarity][:log_dir]
  )
end

template '/etc/clarity.yaml' do
  source 'clarity.yaml'
  mode 0755
  variables(
    :port => node[:clarity][:port],
    :log_files => node[:clarity][:log_files]
  )
end

service 'clarity' do
  action [ :enable, :start ]
end
