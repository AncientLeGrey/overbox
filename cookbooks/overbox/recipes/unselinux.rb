# http://www.electrictoolbox.com/switch-off-selinux-centos-5/

#template '/etc/selinux/conf' do
#  source 'selinux.conf'
#  mode 0644
#end

# alternative:

execute "unsel now!" do
  command 'setenforce 0'
  only_if 'selinuxenabled'
  action :run
end

package 'selinux-policy' do
  action :purge
end

