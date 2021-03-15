class OrdersController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :catch_not_found
  before_action :set_order, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /orders
  # GET /orders.json
  def show
    if current_user.role.nil?
      flash.notice = "You are not authorized for that operation."
      redirect_to home_index_path
    elsif current_user.role.include?("administrator") || current_user.role.include?("intern")
      render :show
    elsif current_user.role.include?("volunteer")
      if current_user.customers.include? @orders
        render :show
      else
        flash.notice = "You are not authorized for that operation."
        redirect_to home_index_path
      end
    else
      flash.notice = "You are not authorized for that operation."
      redirect_to home_index_path
    end
  end

  def new
    # @customer = Customer.find params[:customer_id]
    # @order = @customer.orders.new
    if current_user.role.nil?
      flash.notice = "You are not authorized for that operation."
      redirect_to home_index_path
    elsif current_user.role.include?("administrator") || current_user.role.include?("intern")
      @customer = Customer.find params[:customer_id]
      @order = @customer.orders.new
    else
      flash.notice = "You are not authorized for that operation."
      redirect_to home_index_path
    end
  end

  def edit
    # @order = Order.find(params[:id])
    if current_user.role.nil?
      flash.notice = "You are not authorized for that operation."
      redirect_to home_index_path
    elsif current_user.role.include?("administrator") || current_user.role.include?("intern")
      @order = Order.find(params[:id])
      render :edit
    else
      flash.notice = "You are not authorized for that operation."
      redirect_to home_index_path
    end
  end

  # POST /orders
  # POST /orders.json
  def create
    # @customer = Customer.find params[:customer_id]
    # @order = @customer.orders.new(order_params)
    # if @order.save
    #   flash.notice = "The order record was created successfully."
    #   redirect_to @customer
    # else
    #   flash.now.alert = @order.errors.full_messages.to_sentence
    #   render :edit
    # end
    if current_user.role.nil?
      flash.notice = "You are not authorized for that operation."
      redirect_to home_index_path
    elsif current_user.role.include?("administrator") || current_user.role.include?("intern")
      @customer = Customer.find params[:customer_id]
      @order = @customer.orders.new(order_params)
    else
      flash.notice = "You are not authorized for that operation."
      redirect_to home_index_path
    end

    @customer = Customer.find params[:customer_id]
    @order = @customer.orders.new(order_params)
    if @order.save
      flash.notice = "The order record was created successfully."
      redirect_to @order
    else
      flash.now.alert = @order.errors.full_messages.to_sentence
      render :new
    end
  end

  # PATCH/PUT /customers/1
  # PATCH/PUT /customers/1.json
  def update
    if current_user.role.nil?
      flash.notice = "You are not authorized for that operation."
      redirect_to home_index_path
    elsif current_user.role.include?("administrator") || current_user.role.include?("intern")
      # @customer = Customer.find params[:customer_id]
      @order.update(order_params)
    else
      flash.notice = "You are not authorized for that operation."
      redirect_to home_index_path
    end
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
    # @customer = @order.customer
    # @order.destroy
    # redirect_to @customer, notice: "The order was successfully deleted."
    if current_user.role.nil?
      flash.notice = "You are not authorized for that operation."
      redirect_to home_index_path
    elsif current_user.role.include?("administrator") || current_user.role.include?("intern")
      @customer = @order.customer
      @order.destroy
    else
      flash.notice = "You are not authorized for that operation."
      redirect_to home_index_path
    end
    @customer = @order.customer
    @order.destroy
    respond_to do |format|
      format.html { redirect_to @customer, notice: "The order was successfully deleted." }
      format.json { head :no_content }
    end
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
