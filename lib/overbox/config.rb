module Overbox

  class Config < Vagrant::Config::Base

    configures :overbox

    def projects_path
      @projects_path ||= 'projects'
    end

    def projects_path=(path)
      @projects_path = path
      Project.setup path
    end

    def validate(errors)
      errors.add("projects_path must be a directory") if projects_path && !File.directory?(projects_path)
    end
  end

end