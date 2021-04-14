require "rails_helper"

RSpec.describe "Api::V1::CustomersController#create", :type => :request do
  subject do
    post '/api/v1/customers', params: body, headers: headers
    response
  end

  let(:user) { build(:create_user_request) }

  context 'when create new customer and user is not authenticated' do
    let(:headers) {{}}
    let(:body) { { document: rand(10000...99999).to_s,  full_name: 'Test' } }
    it { expect(subject).to have_http_status(:unauthorized) }
  end

  context 'when create new customer' do
    before do
      post '/sign_up', params: user
      post '/sign_in', params: user
    end
    let(:headers) {{ Authorization: response.headers['Authorization'] }}
    let(:body) { { document: rand(10000...99999).to_s,  full_name: 'Test' } }
    it { expect(subject).to have_http_status(:created) }
  end

  context 'when create new customer with invalid document' do
    before do
      post '/sign_up', params: user
      post '/sign_in', params: user
    end
    let(:headers) {{ Authorization: response.headers['Authorization'] }}
    let(:body) { { document: 'ad3434343',  full_name: 'Test' } }
    it do
      expect(subject).to have_http_status(:bad_request)
      expect(JSON.parse(subject.body, symbolize_names: true).first).to eq('Document must have only numbers')
    end
  end

  context 'when unexpected error on create new customer' do
    before do
      post '/sign_up', params: user
      post '/sign_in', params: user
      allow_any_instance_of(Customer).to receive(:save).and_raise(StandardError)
    end
    let(:headers) {{ Authorization: response.headers['Authorization'] }}
    let(:body) { { document: '123456',  full_name: 'Test' } }
    it do
      expect(subject).to have_http_status(:internal_server_error)
      expect(JSON.parse(subject.body, symbolize_names: true).first).to eq('Undefined failure, contact the administrator.')
    end
  end
end