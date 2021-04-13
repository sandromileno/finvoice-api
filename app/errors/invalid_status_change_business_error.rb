class InvalidStatusChangeBusinessError < BusinessError
  def initialize
    super(I18n.t(:invalid_status_change_business_error))
  end
end