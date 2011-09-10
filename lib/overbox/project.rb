module Overbox

  class Project

    def self.setup(base_path)
      @@base_path = base_path
      unless File.directory?(base_path) then
        FileUtils.mkdir_p(base_path)
      end
    end

    def self.base_path
      @@base_path
    end

    def self.all
      Project.find
    end

    def self.find(query = nil)

      filter = {}

      if query.is_a?(Hash) then
        filter = query
        query = nil
      end

      if query.nil? then
        result = []
        Dir["#{@@base_path}/*"].each do |path|
          if File.directory?(path) then
            project = Project.new(File.basename(path))
            if filter[:cookbooks?] then
              next if not project.cookbooks?
            end
            result << project
          end
        end
        return result
      end
      
      path = "#{@@base_path}/#{query}"

      if File.directory?(path) then
        return Project.new(File.basename(path))
      end

    end

    def self.create(name, options = {})
      Dir.mkdir("#{@@base_path}/#{name}")
      find(name)
    end

    def initialize(name)
      @name = name
    end

    def name
      @name
    end

    def path
      "#{@@base_path}/#{@name}"
    end

    def cookbooks?
      not main_recipe.nil?
    end

    def main_recipe
      file = "#{name.downcase}"
      if File.directory?("#{cookbook_path}/#{file}") then
        file
      end
    end

    def cookbook_path
      cb_path = "#{path}/cookbooks"
      cb_path if File.directory?(cb_path)
    end

    def to_s
      "Project(#{(cookbooks?)?'+':'-'}): #{name}"
    end

  end
  
end
