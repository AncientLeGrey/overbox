load 'spec_helper.rb'

require 'overbox'
require 'rspec/mocks'
require 'fakefs/safe'

module Overbox

  CONTEXTS = {
    'with relative path' =>'spec/examples',
    'with absolute path' => File.expand_path('spec/examples')
  }

  describe Project do

    FakeFS do

      CONTEXTS.each do |ctx, examples_dir|

        context ctx do

          before :each do
            Project.setup(examples_dir)
          end

          it 'should find 0 projects' do
            Project.find.size.should eq(0)
          end

          it 'should not find non-existing projects' do
            Project.find('non-existing').should be(nil)
          end

          it 'should create projects' do
            Project.create('project1')
            Project.create('project2')
            projects = Project.find
            projects.should be_an(Array)
            projects.size.should eq(2)
            projects.each do |project|
              project.should be_a(Project)
            end
          end

          it 'should have an empty cookbook' do
            p1 = Project.create('p1')
            p1.main_recipe.should be(nil)
            p1.cookbooks?.should be(false)
            p1.cookbook_path.should be(nil)
          end

          after :each do
            FileUtils.rm_rf(examples_dir)
          end

        end

      end

    end

  end

end
