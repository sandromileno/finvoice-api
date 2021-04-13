require 'rails_helper'

RSpec.describe Chargebacks::Create do
  let(:invoice) { create(:invoice) }
  let(:chargeback) { build(:chargeback, invoice_id: invoice.id) }

  subject { Chargebacks::Create.execute(chargeback) }

  describe '.execute' do
    # context 'when create new chargeback' do
    #   it { expect(subject).to be_instance_of(Chargeback) }
    # end

    context 'when create new chargeback' do
      before(:example) do
        allow_any_instance_of(Invoice).to receive(:save!).and_raise(StandardError)
      end
      it { expect(subject).to raise_error(DatabaseIntegrationError) }
    end
  end
end

