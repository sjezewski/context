require 'yaml'

module Adapter
    class Kubectl
        class << self
        def update(config)
            context_name = config['context']
            return if context_name.nil?
            set_config(context_name)
        end
        def get_config
            raw = `kubectl config view`
            config = YAML.load(raw)
            config
        end
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
            if updated_config['current-context'] != value
                puts "Could not update config to #{value}.\n#{raw}"
                exit 1
            end
        end

        end
    end 
end
