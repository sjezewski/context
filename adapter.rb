require_relative "adapter/kubectl"
require_relative "adapter/gcloud"
require_relative "adapter/pachctl"

module Adapter
    class << self
        def List
            {
                "kubectl" => Adapter::Kubectl,
                "gcloud" => Adapter::Gcloud,
				"pachctl" => Adapter::Pachctl
            }
        end
    end
end
