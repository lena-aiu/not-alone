require 'application_controller.rb'

class OrdersController < ApplicationController
  # include ApplicationController
  include ApplicationHelper

  rescue_from ActiveRecord::RecordNotFound, with: :catch_not_found
  before_action :set_order, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :is_user_authorized_order, except: [:show]

  # GET /orders
  # GET /orders.json
  def show

    # logic to see if a user is an adm || intern then can see all 
    # volunteer - only show for assigned customers
  end

  def new
    @customer = Customer.find params[:customer_id]
    @order = @customer.orders.new
  end

  def edit
    @order = Order.find(params[:id])
  end

  # POST /orders
  # POST /orders.json
  def create
    @customer = Customer.find params[:customer_id]
    @order = @customer.orders.new(order_params)
    if @order.save
      flash.notice = "The order record was created successfully."
      redirect_to @order
    else
      flash.now.alert = @order.errors.full_messages.to_sentence
      render :edit
    end
  end

  # PATCH/PUT /customers/1
  # PATCH/PUT /customers/1.json
  def update
    if @order.update(order_params)
      flash.notice = "The order record was updated successfully."
      redirect_to @order
    else
      flash.now.alert = @order.errors.full_messages.to_sentence
      render :edit
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @customer = @order.customer
    @order.destroy
    redirect_to @customer, notice: "The order was successfully deleted."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      if params[:customer_id].nil?
        @customer=nil
      else
        @customer=Customer.find(params[:customer_id])
      end
        @order = Order.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def order_params
      params.require(:order).permit(:description, :customer_id, :service_id, :category_id)
    end

    def catch_not_found(e)
      Rails.logger.debug("We had a not found exception.")
      flash.alert = e.to_s
      if !@customer.nil?
        redirect_to @customer
      else
        redirect_to customers_path
      end
    end
end
