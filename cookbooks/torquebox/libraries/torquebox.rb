module TorqueBox
  module Environment

    def find_project(name)
      return name if name.nil?
      case true
      when name.start_with?('/') then
        name
      when File.directory?("#{node[:overbox][:projects_path]}/#{name}") then
        "#{node[:overbox][:projects_path]}/#{name}"
      else
        "#{node[:overbox][:projects_path]}/#{new_resource.cookbook_name}"
      end
    end

    def run(cmd, cwd = nil)
      cmd = "cd #{cwd} ; #{cmd}" if cwd
      script "TorqueBox::Environment - #{cmd}" do
        interpreter 'bash'
        code "runuser - #{node[:torquebox][:user]} -l -c \"#{cmd}\""
      end
    end

    def bundle(action, cwd = nil)
      cmd = "bundle #{action}"
      #cmd = " #{cmd} --without=#{new_resource.without.join(' ')} " unless new_resource.without.empty?
      run(cmd, cwd)
    end

    def rake(options, cwd = node[:torquebox][:home])
      if File.exists("#{cwd}/Gemfile") then
        run("bundle exec rake #{options}", cwd)
      else
        run("rake #{options}", cwd)
      end
    end

    def knob_file(name)
      "#{node[:torquebox][:deploy_dir]}/#{name}-knob.yml"
    end

    #def deploy(context)
    #  rake "-r torquebox-rake-support torquebox:deploy[#{context}]"
    #end

    #def undeploy
    #  rake "-r torquebox-rake-support torquebox:undeploy"
    #end

  end
end