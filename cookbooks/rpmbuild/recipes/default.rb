require_recipe 'torquebox'

gem_package 'net-ssh' do
  gem_binary node[:torquebox][:gem_wrapper]
end

gem_package 'net-sftp' do
  gem_binary node[:torquebox][:gem_wrapper]
end

package 'epel-release'
package 'cantiere'
