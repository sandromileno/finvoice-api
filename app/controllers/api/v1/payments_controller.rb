class Api::V1::PaymentsController < ApplicationController
  before_action :build_payment, only: :create

  def create
    return render json: @payment.error_messages, status: :bad_request unless @payment.valid?
    render json: Payments::Create.execute(@payment), status: :created
  rescue BusinessError => err
    render json: err.errors, status: :bad_request
  rescue => err
    render json: err.errors, status: :internal_server_error
  end

  private

  def build_payment
    @payment = PaymentBuilder.build(params)
  rescue ResourceNotFound
    render status: :not_found
  end
end
