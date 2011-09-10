$: << File.dirname( __FILE__ )

require 'vagrant'
require 'overbox/version'
require 'overbox/config'
require 'overbox/command'
require 'overbox/middleware'
require 'overbox/project'

bundle = Vagrant::Action::Builder.new do
  use Overbox::Middleware::Bundle
end

Vagrant::Action.register(:bundle, bundle)
