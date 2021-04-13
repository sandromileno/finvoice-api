class InvalidPaymentAmountBusinessError < BusinessError
  def initialize
    super(I18n.t(:invalid_payment_amount))
  end
end