module Adapter
    class Pachctl
        class << self
			def supported?(setting)
				["address"].include? setting
			end

            def use(config)
                if config['address']
                    puts config['address']
                else
                    exit 1
                end
            end
            def run_flags
                c = get_config
                "ADDRESS=#{c['address']}"
            end
            def get_config
                c = {}
                address=`echo $ADDRESS`
                unless address.nil?
                    c['address'] = address
                end
                c
            end
            def set_config
                # Nothing to do here
                # Can't modify env variables from here, so have to rely on
                # 'run_flags()' wrapper
                # 
                # For the actual execution method, refer to 'context.sh'
            end
        end
    end
end
