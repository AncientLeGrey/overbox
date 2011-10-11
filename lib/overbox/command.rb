module Overbox

  class Command < Vagrant::Command::GroupBase

    APP_TYPES = ['rack', 'sinatra', 'rails']
    RUBY_VERSIONS = ['1.8', '1.9']

    source_root(File.dirname( __FILE__ ) + '/../templates')

    register "project", "Manage multiple Projects inside VM"

    desc 'list', 'lists projects inside VM'
    def list
      Project.find.each do |project|
        env.ui.info project
      end
    end

    desc 'add PROJECT', 'adds example project to VM'
    method_option :type, :default => 'sinatra'
    method_option 'ruby-version'
    def add(name = nil)

      if name.nil? then
        env.ui.error "No project name specified"
        raise Thor::RequiredArgumentMissingError.new('aborted')
      end

      if options['ruby-version'] then
        unless RUBY_VERSIONS.include?(options['ruby-version']) then
          env.ui.error "Invalid ruby_version '#{options['ruby-version']}'. Allowed values: #{RUBY_VERSIONS.join(', ')}"
          raise Thor::MalformattedArgumentError.new('aborted')
        end
        @ruby_versions = [ options['ruby-version'] ]
      else
        @ruby_versions = RUBY_VERSIONS
      end

      env.ui.info "Creating example project #{name}"

      @name = name
      @type = options[:type]
      case @type
      when 'sinatra'
        template 'sinatra/cookbook.tt', "#{Project.base_path}/#{name}/cookbooks/#{name.downcase}/recipes/default.rb"
        template 'sinatra/jenkins-rake.tt', "#{Project.base_path}/#{name}/cookbooks/#{name.downcase}/templates/default/rake.xml"
        template 'sinatra/gemfile.tt', "#{Project.base_path}/#{name}/Gemfile"
        template 'sinatra/rakefile.tt', "#{Project.base_path}/#{name}/Rakefile"
        template 'sinatra/spec.tt', "#{Project.base_path}/#{name}/spec/example_spec.rb"
        template 'sinatra/spec_helper.tt', "#{Project.base_path}/#{name}/spec/spec_helper.rb"
        template 'sinatra/rackup.tt', "#{Project.base_path}/#{name}/config.ru"
        template 'sinatra/app.tt', "#{Project.base_path}/#{name}/#{name}.rb"
        template 'sinatra/layout.tt', "#{Project.base_path}/#{name}/views/layout.slim"
        template 'sinatra/index.tt', "#{Project.base_path}/#{name}/views/index.slim"
        template 'sinatra/style.tt', "#{Project.base_path}/#{name}/views/style.less"
        template 'sinatra/torquebox.tt', "#{Project.base_path}/#{name}/config/torquebox.yml"
        template 'sinatra/torquebox_logger.tt', "#{Project.base_path}/#{name}/lib/torquebox_logger.rb"
      when 'rack'
        env.ui.error "Not implemented"
        raise Thor::MalformattedArgumentError.new('aborted')
      when 'rails'
        env.ui.error "Not implemented"
        raise Thor::MalformattedArgumentError.new('aborted')
      else
        env.ui.error "Applicationtype #{@type} is not supported."
        raise Thor::MalformattedArgumentError.new('aborted')
      end
      
    end

  end

end
