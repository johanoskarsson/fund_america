module FundAmerica
  class InvestorPaymentMethod
    class << self

      # End point: https://apps.fundamerica.com/api/investor_payment_methods (POST)
      # Usage: FundAmerica::InvestorPaymentMethod.create(investor_payment_id)
      # Output: Creates a new investor payment method
      def create(options)
        API::request(:post, FundAmerica.base_uri + "investor_payment_methods", options)
      end

    end
  end
end