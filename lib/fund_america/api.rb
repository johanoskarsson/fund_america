module FundAmerica
  class API
    class << self

      # This method is called from each end point method to make API requests
      # using HTTParty gem. Takes the method, uri and options as input
      # Handles response and errors
      def request method, uri, options={}
        options = FundAmerica.basic_auth.merge!({:body => options})
        uri = FundAmerica.base_uri + uri
        response = HTTParty.send(method, uri, options)
        parsed_response = parse_response_body(response.body, response.code.to_i)
        if response.code.to_i == 200
          # Returns parsed_response - a hash of response body
          # if response is successful
          parsed_response
        else
          # Raises error if the response is not sucessful
          raise FundAmerica::Error.new(parsed_response, response.code.to_i)
        end
      end

      # End point: https://sandbox.fundamerica.com/api/test_mode/clear_data (POST)
      # Usage: FundAmerica::API.clear_data
      # Output: Clears all test data created in sandbox mode
      # Important: Sandbox mode only method
      def clear_data
        API::request(:post, 'test_mode/clear_data')
      end

      # End point: https://apps.fundamerica.com/api/investorsuitabilitytokens (POST)
      # Usage: FundAmerica::API.investor_suitabilitytokens(options)
      def investor_suitabilitytokens(options)
        API::request(:post, 'investorsuitabilitytokens', options)
      end

      # End point: https://apps.fundamerica.com/api/ledger_entries/:id (GET)
      # Usage: FundAmerica::API.ledger_entry(ledger_entry_id)
      def ledger_entry(ledger_entry_id)
        API::request(:get, "ledger_entries/#{ledger_entry_id}")
      end

      # Parses a JSON response
      def parse_response_body(body, response_code)
        # RFC4627 restricts the valid top-level JSON to objects and arrays.
        # ECMA-404 and RFC7159 which supersedes RFC4627 does not restrict the
        # top-level values.  This is the standard ruby hack to deal with this.
        parsed_response = JSON.parse("[#{body}]")[0]
      rescue JSON::ParserError => _e
        # Would like to do an error message like:
        #   "Could not parse response body as JSON: #{body}"
        # but this gem only uses pre-assigned error message codes, and
        # the "else" message is least misleading about what went wrong.
        # See: https://github.com/rubyeffect/fund_america/blob/5e6b5184d1e5ca4bb7ccf7c17dd9d174f5ec6210/lib/fund_america/error.rb#L12-L28
        raise FundAmerica::Error.new(body, response_code)
      end
    end
  end
end
