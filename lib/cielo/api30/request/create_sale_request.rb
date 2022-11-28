require "cielo/api30/request/cielo_request"

module Cielo
  module API30
    module Request
      class CreateSaleRequest < CieloRequest
        attr_accessor :environment, :mode
        private :environment

        def initialize(merchant, environment, mode)
          super(merchant)
          @environment = environment
          @mode = mode
        end

        def execute(sale,mode: 'cielo')
          uri = URI.parse(@mode == 'cielo' ? [@environment.api, "1", "sales"].join("/") : [@environment.braspag_api, "v2", "sales"].join("/"))
          Cielo::API30::Sale.from_json(send_request("POST", uri, sale))
        end
      end
    end
  end
end
