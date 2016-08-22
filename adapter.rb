require_relative "adapter/kubectl"


module Adapter
    class << self
        def List
            {
                "kubectl" => Adapter::Kubectl
            }
        end
    end
end
