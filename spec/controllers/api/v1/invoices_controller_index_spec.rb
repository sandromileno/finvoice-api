require "rails_helper"

RSpec.describe "Api::V1::InvoicesController#index", :type => :request do
  subject do
    get "/api/v1/invoices"
    response
  end

  context 'when get all invoices and has no invoices' do
    it do
      expect(subject).to have_http_status(:ok)
      expect(JSON.parse(subject.body, symbolize_names: true)).to be_empty
    end
  end
end
