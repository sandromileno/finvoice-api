class InvalidAmountChangeBusinessError < BusinessError
  def initialize
    super(I18n.t(:invalid_amount_change_business_error))
  end
end