class Api::V1::InvoicesController < ApplicationController
  before_action :build_invoice, only: :create
  skip_before_action :authenticate_user!, only: [:index]
  before_action :load_invoice, only: :update

  def index
    return render json: Invoice.where(status: params[:status]), status: 200 if params[:status].present?
    render json: Invoice.all, status: 200
  end

  def create
    return render json: @invoice.error_messages, status: :bad_request unless @invoice.valid? && params[:scan]
    render json: Invoices::Create.execute(@invoice, params[:scan]), status: :created
  rescue BusinessError => err
    render json: err.errors, status: :bad_request
  rescue => err
    render json: err.errors, status: :internal_server_error
  end

  def update
    return render json: Invoices::Update.execute(@invoice, params: params.permit(:amount, :status)), status: :ok if params[:amount] || Invoice::INVALID.eql?(params[:status]&.upcase)
    render status: :bad_request
  rescue BusinessError => err
    render json: err.errors, status: :bad_request
  rescue => err
    render json: err.errors, status: :internal_server_error
  end

  private

  def load_invoice
    @invoice = Invoice.by_invoice_id_and_customer_id(params[:id], params[:customer_id]).first
    render status: :not_found unless @invoice.present?
  end

  def build_invoice
    @invoice = InvoiceBuilder.build(params)
  rescue ResourceNotFound
    render status: :not_found
  end
end