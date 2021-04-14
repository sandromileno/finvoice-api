
require "rails_helper"

RSpec.describe "Api::V1::ChargebacksController#create", :type => :request do
  subject do
    post "/api/v1/customers/#{invoice.customer.key}/invoices/#{invoice.key}/chargebacks", params: body, headers: headers
    response
  end

  let(:user) { build(:create_user_request) }

  context 'when create a chargeback' do
    before do
      post '/sign_up', params: user
      post '/sign_in', params: user
    end

    let(:headers) {{ Authorization: response.headers['Authorization'] }}

    let(:body) { build(:create_chargeback_request) }
    let(:invoice) { create(:invoice) }

    it do
      expect(subject).to have_http_status(:created)
      expect(JSON.parse(subject.body, symbolize_names: true)[:id]).not_to be_nil
      expect(JSON.parse(subject.body, symbolize_names: true)[:amount]).not_to be_nil
    end
  end

  context 'when create a chargeback with a invalid invoice id' do
    before do
      post '/sign_up', params: user
      post '/sign_in', params: user
    end

    let(:headers) {{ Authorization: response.headers['Authorization'] }}

    let(:body) { build(:create_chargeback_request) }
    let(:invoice) { build(:invoice) }

    it do
      expect(subject).to have_http_status(:not_found)
    end
  end

  context 'when unexpected error on create new chargeback' do
    before do
      post '/sign_up', params: user
      post '/sign_in', params: user
      expect_any_instance_of(Invoice).to receive(:save).and_raise(StandardError)
    end

    let(:headers) {{ Authorization: response.headers['Authorization'] }}

    let(:body) { build(:create_chargeback_request) }
    let(:invoice) { create(:invoice) }

    it do
      expect(subject).to have_http_status(:internal_server_error)
      expect(JSON.parse(subject.body, symbolize_names: true).first).to eq('Undefined failure, contact the administrator.')
    end
  end
end
