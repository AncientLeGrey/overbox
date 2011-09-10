module Overbox

  module Middleware

    class Base
      def initialize(app, env)
        @app = app
        @env = env
      end
      def projects_dir
        "#{@env["config"].vm.shared_folders["v-root"][:guestpath]}/#{@env["config"].overbox.projects_dir}"
      end
    end

    class Bundle < Base
      def call(env)
        @app.call(env)
      end
    end

  end

end
