module Adapter
    class Gcloud
        class << self
        def use(config)
             get_config   
        end
        # Gets config from current environment's state
        def get_config
        end
        # Sets the current environment's state to the supplied value
        def set_config(value)
            valid_configs = get_valid_configs
            if !valid_configs.include? value
                puts "Cannot set gcloud config to #{value}"
                valid_configs_string = valid_configs.collect {|c| "\t- #{c}"}.join("\n")
                puts "Valid options are:\n#{valid_configs_string}"
                puts "Update the local setting by running:"
                puts "\t context set gcloud config <name>"
                puts "To learn more about creating a gcloud config run:\n\tgcloud topic configurations"
                exit 1
            end
            raw = `gcloud config configurations activate #{value}`
            updated_config = get_config
            if updated_config[@@field] != value
                puts "Could not update config to #{value}.\n#{raw}"
                exit 1
            end
        end

        private

        def list_valid_configs
            # Surprisingly, `gcloud config list` does not list the available configs
            # ... so we'll parse the results of the prompt from `gcloud init`
            p = IO.popen("gcloud init 2>/tmp/gc_config &", "w+")
            sleep 5 # Give gcloud time to connect. Hacky.
            p.close_write
            raw = File.read("/tmp/gc_config")
            Process.kill("INT", p.pid)
            configs = []
            raw.split("\n").each do |line|
                # Find line that contains config name
                # e.g:
                # [4] Switch to and re-initialize existing configuration: [personal]
                if line =~ /existing configuration.*?\[(.*?)\]/
                    configs << $1
                end
            end
            configs
        end

        end
    end
end
