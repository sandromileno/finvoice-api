class PaymentSerializer < ActiveModel::Serializer
  attributes :id, :amount, :created_at, :updated_at

  def id
    object.key
  end
end