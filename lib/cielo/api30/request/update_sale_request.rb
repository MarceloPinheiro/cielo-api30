require "cielo/api30/request/cielo_request"

module Cielo
  module API30
    module Request
      class UpdateSaleRequest < CieloRequest
        attr_accessor :environment,
                      :type,
                      :service_tax_amount,
                      :amount,
                      :mode

        private :environment, :type

        def initialize(type, merchant, environment, mode)
          super(merchant)
          @environment = environment
          @type = type
          @mode = mode
        end

        def execute(payment_id, mode: 'cielo')
          uri = URI.parse(mode == 'cielo' ? [@environment.api, "1", "sales", payment_id, type].join("/") : [@environment.braspag_api, "v2", "sales", payment_id, type].join("/"))
          params = {}

          params["amount"] = amount if amount
          params["serviceTaxAmount"] = service_tax_amount if service_tax_amount

          uri.query = URI.encode_www_form(params)

          Cielo::API30::Payment.from_json(send_request("PUT", uri))
        end
      end
    end
  end
end
