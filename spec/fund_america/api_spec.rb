require 'spec_helper'

describe FundAmerica::API do
  context '#clear_data' do
    it 'must have a response' do
      expect(FundAmerica::API.clear_data).not_to be nil
    end
  end

  context '#parse_response_body' do
    let(:body) { nil }
    subject { FundAmerica::API.parse_response_body(body, 404) }

    context 'sent a response.body of JSON' do
      let(:body) { '{"message": "Could not find an entity with that ID"}' }
      it 'parses the JSON without error' do
        expect(subject).to eq({'message' => 'Could not find an entity with that ID'})
      end
    end

    context 'sent a response.body of HTML' do
      let(:body) { '<!DOCTYPE html><html><head></head><body>Oops we sent HTML</body></html>' }
      it 'throws an expected error' do
        expect { subject }.to raise_error(FundAmerica::Error)
      end
    end
  end
end
