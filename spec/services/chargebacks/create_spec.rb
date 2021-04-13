require 'rails_helper'

RSpec.describe Chargebacks::Create do
  let(:chargeback) { build(:chargeback) }

  subject { Chargebacks::Create.execute(chargeback) }

  describe '.execute' do
    context 'when create new chargeback' do
      before { allow_any_instance_of(Chargeback).to receive(:save!).and_return(true) }
      it { expect(subject).to be_truthy }
    end
  end

  describe '.execute' do
    context 'when create new chargeback' do
      before do
        allow_any_instance_of(Chargeback).to receive(:save!).and_raise(ActiveRecord::RecordNotSaved)
      end
      it { expect(subject).to raise_error(DatabaseIntegrationError) }
    end
  end
end

