class ChargebackSerializer < ActiveModel::Serializer
  attributes :id, :amount, :reason, :created_at, :updated_at

  def id
    object.key
  end
end