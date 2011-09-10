module Overbox

  class Command < Vagrant::Command::GroupBase

    source_root(File.dirname( __FILE__ ) + '/../templates')

    register "project", "Manage multiple Projects inside VM"

    desc 'list', 'lists projects inside VM'
    def list
      Project.find.each do |project|
        env.ui.info project
      end
    end

    desc 'add PROJECT', 'adds project to VM'
    def add(name = nil)
      if name.nil? then
        env.ui.error "no name specified"
        raise Thor::RequiredArgumentMissingError.new('')
      end

      env.ui.info "Creating empty project #{name}"

      @name = name
      template 'cookbook.tt', "#{Project.base_path}/#{name}/cookbooks/#{name.downcase}/recipes/default.rb"
      template 'jenkins-rake.tt', "#{Project.base_path}/#{name}/cookbooks/#{name.downcase}/templates/default/rake.xml"
      template 'gemfile.tt', "#{Project.base_path}/#{name}/Gemfile"
      template 'rakefile.tt', "#{Project.base_path}/#{name}/Rakefile"
      template 'spec.tt', "#{Project.base_path}/#{name}/spec/example_spec.rb"
      template 'rackup.tt', "#{Project.base_path}/#{name}/config.ru"

    end

  end

end
