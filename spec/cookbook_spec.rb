load 'spec_helper.rb'

require 'overbox'

module Overbox

  describe Project do

    context 'with existing cookbook' do

      before :each do
        Project.setup(File.dirname( __FILE__ ) + '/example')
        @p1 = Project.find 'testproject'
      end

      it 'project should be found' do
        @p1.should_not be_nil
      end

      it 'should have a main recipe with the projects name' do
        @p1.main_recipe.should == 'testproject'
      end

      it 'should have a cookbook path' do
        @p1.cookbook_path.should =~ /example\/testproject\/cookbooks/
      end

    end

  end

end
