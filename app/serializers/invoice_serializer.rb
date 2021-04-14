class InvoiceSerializer < ActiveModel::Serializer
  attributes :id, :identifier, :amount, :paid, :chargebacked, :due_date, :status, :scan, :created_at, :updated_at

  def id
    object.key
  end

  def identifier
    object.external_key
  end
end