class Api::V1::ChargebacksController < ApplicationController
  before_action :build_chargeback, only: :create

  def create
    return render json: @chargeback.error_messages, status: :bad_request unless @chargeback.valid?
    render json: Chargebacks::Create.execute(@chargeback), status: :created
  rescue BusinessError => err
    render json: err.errors, status: :bad_request
  rescue => err
    render json: err.errors, status: :internal_server_error
  end

  private

  def build_chargeback
    @chargeback = ChargebackBuilder.build(params)
  rescue ResourceNotFound
    render status: :not_found
  end
end
