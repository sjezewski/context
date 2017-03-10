module Adapter
    class Pachctl
        class << self
			def supported?(setting)
				["init_cmd", "address"].include? setting
			end

            def use(config)
				if config['init_cmd']
					system config['init_cmd']
				end
            end
        end
    end
end
