module Adapter
    class Gcloud
        class << self

		def supported?(setting)
			["config"].include? setting
		end

        def use(config)
            config_name = config['config']
            return if config_name.nil?
            set_config(config_name)
        end

        # Gets config from current environment's state
        def get_config
            raw=`gcloud config list 2>&1 | head -n 1`
            # e.g: 'Your active configuration is: [foo]'
            raw =~ /\[(.*?)\]/
            $1
        end

        # Sets the current environment's state to the supplied value
        def set_config(value)
            valid_configs = list_valid_configs
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
            if updated_config != value
                puts "Could not update config to #{value}.\n#{raw}"
                exit 1
            end
        end

        private

        def list_valid_configs
            raw = `gcloud config configurations list | tail -n +2 | cut -f 1 -d " "`
            raw.split("\n")
        end

        end
    end
end
