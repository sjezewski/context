require 'yaml'

module Adapter
    class Kubectl
        @@field = 'current-context'

        class << self

		def supported?(setting)
			["init_cmd"].include? setting
		end

        # Uses the config loaded from a .ctx file to set the environment's state
        def use(config)
			cmd = config['init_cmd']
			unless cmd.nil?
				system cmd
			end
        end

        end
    end 
end
