class CustomerSerializer < ActiveModel::Serializer
  attributes :id, :full_name, :document, :created_at, :updated_at

  def id
    object.key
  end
end