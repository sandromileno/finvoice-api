class Customer < ApplicationRecord
  include ErrorConverter

  # associations
  has_many :invoices
  has_one :user
  belongs_to :user

  # validations
  validates :full_name, :document, presence: true
  validates :document, uniqueness: true
  validates :document, format: { with: /\A\d+\z/, message: I18n.t(:only_numbers)}

  # queries
  scope :by_customer_id, (->(customer_id) { Customer.find_by(key: customer_id) })

  # triggers
  after_initialize :configure_unique_key

  protected

  def configure_unique_key
    self.key ||= SecureRandom.uuid
  end
end
