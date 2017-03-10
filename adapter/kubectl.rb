require 'yaml'

module Adapter
    class Kubectl
        @@field = 'current-context'

        class << self

		def supported?(setting)
			["context", "init_cmd", "kubeconfig"].include? setting
		end

        # Uses the config loaded from a .ctx file to set the environment's state
        def use(config)
			cmd = config['init_cmd']
			unless cmd.nil?
				system cmd
			end

            context_name = config['context']
            return if context_name.nil?

            set_config(context_name)
        end
        # Gets the current environment's state and saves it to a .ctx file
        def update_config
            #c = get_config
            #set_config c[@@field]
        end

        end
    end 
end
