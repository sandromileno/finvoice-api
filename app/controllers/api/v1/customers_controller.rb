class Api::V1::CustomersController < ApplicationController
   before_action :build_customer, only: :create
   before_action :load_customer, only: :show

   def show
     return render json: @customer, status: :ok if @customer.present?
     render status: :not_found
   end

  def create
    return render json: @customer.error_messages, status: :bad_request unless @customer.valid?
    render json: Customers::Create.execute(@customer), status: :created
  rescue => err
    render json: err.errors, status: :internal_server_error
  end

   private

   def load_customer
     @customer = Customer.by_customer_id(params[:id]).first
   end

   def build_customer
    @customer = CustomerBuilder.build(params.merge(user_id: current_user.id))
   end
end
