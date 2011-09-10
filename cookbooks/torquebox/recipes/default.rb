require_recipe 'java6'

yum_repo 'torquebox' do
  baseurl node[:torquebox][:yum_repo]
end

node[:torquebox][:components].each do |component|
  require_recipe "torquebox::#{component}"
end
