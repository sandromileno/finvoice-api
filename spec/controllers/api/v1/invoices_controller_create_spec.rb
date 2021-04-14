require "rails_helper"

RSpec.describe "Api::V1::InvoicesController#create", :type => :request do
  subject do
    post "/api/v1/customers/#{customer_id}/invoices", params: body, headers: headers
    response
  end

  let(:user) { build(:create_user_request) }

  context 'when create a new invoice' do
    before do
      post '/sign_up', params: user
      post '/sign_in', params: user
    end

    let(:headers) {{ Authorization: response.headers['Authorization'] }}

    let(:body) { build(:create_invoice_request) }
    let(:customer) { create(:customer) }
    let(:customer_id) { customer.key }

    it do
      expect(subject).to have_http_status(:created)
      expect(JSON.parse(subject.body, symbolize_names: true)[:scan]).not_to be_nil
      expect(JSON.parse(subject.body, symbolize_names: true)[:id]).not_to be_nil
    end
  end

  context 'when create a new invoice and customer does not exists' do
    before do
      post '/sign_up', params: user
      post '/sign_in', params: user
    end

    let(:headers) {{ Authorization: response.headers['Authorization'] }}

    let(:body) { build(:create_invoice_request) }
    let(:customer_id) { SecureRandom.uuid }

    it { expect(subject).to have_http_status(:not_found) }
  end

  context 'when create a new invoice and customer does not exists' do
    before do
      post '/sign_up', params: user
      post '/sign_in', params: user
    end

    let(:headers) {{ Authorization: response.headers['Authorization'] }}

    let(:body) { build(:create_invoice_request) }
    let(:customer_id) { SecureRandom.uuid }

    it { expect(subject).to have_http_status(:not_found) }
  end
end