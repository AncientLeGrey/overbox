default[:torquebox][:yum_repo]   = 'http://dl.dropbox.com/u/153388/torquebox.rpm/noarch/'
default[:torquebox][:version]    = nil
default[:torquebox][:home]       = '/var/lib/torquebox'
default[:torquebox][:user]       = 'torquebox'
default[:torquebox][:group]      = 'torquebox'
default[:torquebox][:service]    = 'torquebox'
default[:torquebox][:conf_dir]   = '/etc/torquebox.d'
default[:torquebox][:deploy_dir] = "#{node[:torquebox][:home]}/apps"
default[:torquebox][:jruby_home] = "#{node[:torquebox][:home]}/jruby"
default[:torquebox][:app_repo]   = "#{node[:torquebox][:home]}-apprepo"
default[:torquebox][:gem_wrapper]= "#{node[:torquebox][:jruby_home]}/bin/gem_warpper"
default[:torquebox][:jvm_args]   = '-Xms128m -Xmx512m -XX:PermSize=256m -Dorg.jboss.resolver.warning=true -Dsun.rmi.dgc.client.gcInterval=3600000 -Dsun.rmi.dgc.server.gcInterval=3600000'
default[:torquebox][:ip]         = '0.0.0.0'

default[:torquebox][:components] = ['server']

default[:jboss][:home]           = "#{node[:torquebox][:home]}/jboss"
default[:jboss][:deploy_dir]     = "#{node[:jboss][:home]}/server/default/deploy"
default[:jboss][:lib_dir]        = "#{node[:jboss][:home]}/server/default/lib"
default[:jboss][:log_dir]        = "#{node[:jboss][:home]}/server/default/log"
default[:jboss][:user]           = node[:torquebox][:user]
default[:jboss][:group]          = node[:torquebox][:group]
default[:jboss][:service]        = node[:torquebox][:service]
default[:jboss][:conf_dir]       = node[:torquebox][:conf_dir]
