require 'yaml'

module Adapter
    class Kubectl
        @@field = 'current-context'

        class << self

		def supported?(setting)
			["context"].include? setting
		end

        # Uses the config loaded from a .ctx file to set the environment's state
        def use(config)
            context_name = config['context']
            return if context_name.nil?
            set_config(context_name)
        end
        # Gets config from current environment's state
        def get_config
            raw = `kubectl config view`
            config = YAML.load(raw)
            config
        end
        # Sets the current environment's state to the supplied value
        def set_config(value)
            contexts = get_config()['contexts']
            found = false
            contexts.each do |context|
                found = true if context["name"] == value
            end
            if !found
                names = contexts.collect {|c| "\t- #{c['name']}"}.join("\n")
                puts "Context '#{value}' not found in list of viable contexts:\n#{names}"
                puts "Update the local setting by running:"
                puts "\tcontext set kubectl context <name>"
                exit 1
            end
            raw = `kubectl config use-context #{value}`
            updated_config = get_config
            if updated_config[@@field] != value
                puts "Could not update config to #{value}.\n#{raw}"
                exit 1
            end
        end
        # Gets the current environment's state and saves it to a .ctx file
        def update_config
            #c = get_config
            #set_config c[@@field]
        end

        end
    end 
end
