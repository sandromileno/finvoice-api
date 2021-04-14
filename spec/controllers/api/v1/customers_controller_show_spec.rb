require "rails_helper"

RSpec.describe "Api::V1::CustomersController#show", :type => :request do
  subject do
    get "/api/v1/customers/#{customer_id}", headers: headers
    response
  end

  let(:user) { build(:create_user_request) }

  context 'when get customer by id and does not exist' do
    let(:customer_id) { SecureRandom.uuid }
    before do
      post '/sign_up', params: user
      post '/sign_in', params: user
    end
    let(:headers) {{ Authorization: response.headers['Authorization'] }}

    it { expect(subject).to have_http_status(:not_found) }
  end

  context 'when get customer by id' do
    let(:customer) { create(:customer) }
    let(:customer_id) { customer.key }
    before do
      post '/sign_up', params: user
      post '/sign_in', params: user
    end
    let(:headers) {{ Authorization: response.headers['Authorization'] }}
    let(:body) { { document: rand(10000...99999).to_s,  full_name: 'Test' } }

    it do
      expect(JSON.parse(subject.body, symbolize_names: true)[:id]).to eq(customer.key)
      expect(JSON.parse(subject.body, symbolize_names: true)[:full_name]).to eq(customer.full_name)
      expect(JSON.parse(subject.body, symbolize_names: true)[:document]).to eq(customer.document)
    end
  end
end