class DatabaseIntegrationError < BaseError
  def initialize
    super(I18n.t(:undefined_failure))
  end
end