gem_package 'torquebox' do
  version node[:torquebox][:version] if node[:torquebox][:version]
end
