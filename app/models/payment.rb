class Payment < ApplicationRecord
  include ErrorConverter

  # validations
  validates :amount, numericality: true

  # associations
  belongs_to :invoice

  # triggers
  after_initialize :configure_unique_key

  protected

  def configure_unique_key
    self.key ||= SecureRandom.uuid
  end
end
