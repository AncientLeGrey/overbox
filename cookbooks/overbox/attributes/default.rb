default[:overbox][:projects_path] = "#{node[:vagrant][:directory]}/#{node[:vagrant][:config][:overbox][:projects_path]}"
default[:overbox][:yum_repos] = {
  'overbox-base-repo' => 'http://ancientlegrey.github.com/overbox-base-repo/noarch'
}
default[:overbox][:selinux] = false
