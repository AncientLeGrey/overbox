require 'lib/overbox'
require 'yaml'

Vagrant::Config.run do |config|

  config_name = 'config'
  conf = case true
    when File.exists?("#{config_name}.yaml") then YAML.load_file("#{config_name}.yaml")
    when File.exists?("#{config_name}.json") then JSON.parse(File.read("#{config_name}.json"))
    else {}
  end

  config.ssh.max_tries = 15 # default: 10
  config.ssh.timeout = 60 # default: 30

  #config.vm.boot_mode = :gui

  conf['shared_folders'].each do |name,folder|
    folder.each do |remote,local|
      config.vm.share_folder name, remote, local
    end unless folder.nil?
  end unless conf['shared_folders'].nil?

  config.vm.box = conf['box']['name']
  config.vm.box_url = conf['box']['url']

  config.vm.customize do |vm|
    vm.memory_size = conf['box']['ram']
    vm.name = File.basename(File.dirname(__FILE__))
  end

  conf['portforwarding'].each do |key,value|
    name = key
    if value.is_a? Hash then
      config.vm.forward_port name, value['lokal'], value['remote']
    else
      config.vm.forward_port name, value, value
    end
  end unless conf['portforwarding'].nil?

  config.overbox.projects_path = 'projects'
  
  config.vm.provision :chef_solo do |chef|

    chef.cookbooks_path = ['cookbooks']
    conf['chef']['recipes'].each do |recipe|
      chef.add_recipe recipe
    end unless conf['chef'].nil?

    # load projects cookbooks
    Overbox::Project.find(:cookbooks? => true).each do |project|
      chef.cookbooks_path << project.cookbook_path
      chef.add_recipe project.main_recipe
    end

    chef.json=conf['chef']['config'] unless conf['chef'].nil?

  end

end
