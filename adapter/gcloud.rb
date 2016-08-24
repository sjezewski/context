module Adapter
    class Gcloud
        class << self
        def use(config)
             get_config   
        end
        # Gets config from current environment's state
        def get_config
            # Surprisingly, `gcloud config list` does not list the available configs
            # ... so we'll parse the results of the prompt from `gcloud init`
            p = IO.popen("gcloud init 2>/tmp/gc_config &", "w+")
            sleep 5 # Give gcloud time to connect. Hacky.
            p.close_write
            raw = File.read("/tmp/gc_config")
            Process.kill("INT", p.pid)
#  [3] Switch to and re-initialize existing configuration: [default]
# [4] Switch to and re-initialize existing configuration: [personal]
            raw.split("\n").each do |line|
                # Find line that contains config name
            end
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
        end
    end
end
