class OrdersController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :catch_not_found
    layout 'order_layout'
    before_action :set_order, only: [:show, :edit, :update, :destroy]
#ORDER1
    rescue_from ActiveRecord::RecordNotFound, with: :catch_not_found1
    layout 'order_layout1'
    before_action :set_order1, only: [:show1, :edit1, :update1, :destroy1]

    # GET /orders
    # GET /orders.json
    def index
      @customer = Customer.find params[:customer_id]
      @orders = Order.all
    end
  
    def show      
    end
    
    def new
      @customer = Customer.find params[:customer_id]
      @order = @customer.orders.new
      #@order = @customer.orders.new order_params
      #@order.save
      #@order = Order.new
    end
  
    
    def edit
      
      @order = Order.find(params[:id])
    end
  
    # POST /orders
    # POST /orders.json
# orders#create
# new_customer_order GET    /customers/:customer_id/orders/new(.:format)              
# customers#index
# POST   /customers(.:format)                                                                     customers#create
# new_customer GET    /customers/new(.:format)                                                                 customers#new
# edit_customer GET    /customers/:id/edit(.:format)                                                            
    def create
      @customer = Customer.find params[:customer_id]
#      @order = @customer.orders.new order_params
#      @order.save
      @order = @customer.orders.new(order_params)
      if @order.save
        flash.notice = "The order record was created successfully."
        redirect_to @customer
      else
        flash.now.alert = @order.errors.full_messages.to_sentence
        render :new  
      end
    end
  
    # PATCH/PUT /customers/1
    # PATCH/PUT /customers/1.json
    def update

      if @order.update(order_params)
        flash.notice = "The order record was updated successfully."
        redirect_to @customer
      else
        flash.now.alert = @order.errors.full_messages.to_sentence
        render :edit
      end
    end
  
    # DELETE /orders/1
    # DELETE /orders/1.json
    def destroy
      @order.destroy
      respond_to do |format|
        format.html { redirect_to services_url, notice: 'Order was successfully destroyed.' }
        format.json { head :no_content }
      end
    end
######ORDER1
  # GET /customers
  # GET /customers.json  
  def index1
    @orders = Order.all
  end

  # GET /customers/1
  # GET /customers/1.json
  def show1
  end

  # GET /orders/new
  def new1
    @order = Order.new
  end

  # GET /orders/1/edit
  def edit1
  end

  # POST /orders
  # POST /orders.json
  def create1
    @order = Order.new(order_params)
    if @order.save
      flash.notice = "The order record was created successfully."
      redirect_to @order
    else
      flash.now.alert = @order.errors.full_messages.to_sentence
      render :new1  
    end
  
    # @customer = Customer.new(customer_params)
    # respond_to do |format|
    #   if @customer.save
    #     format.html { redirect_to @customer, notice: 'Customer was successfully created.' }
    #     format.json { render :show, status: :created, location: @customer }
    #   else
    #     format.html { render :new }
    #     format.json { render json: @customer.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # PATCH/PUT /customers/1
  # PATCH/PUT /customers/1.json
  def update1
    if @order.update(order_params)
      flash.notice = "The order record was updated successfully."
      redirect_to @order
    else
      flash.now.alert = @order.errors.full_messages.to_sentence
      render :edit1
    end
    # respond_to do |format|
    #   if @customer.update(customer_params)
    #     format.html { redirect_to @customer, notice: 'Customer was successfully updated.' }
    #     format.json { render :show, status: :ok, location: @customer }
    #   else
    #     format.html { render :edit }
    #     format.json { render json: @customer.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # DELETE /customers/1
  # DELETE /customers/1.json
  def destroy1
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  #########PRIVATE  
    private
      # Use callbacks to share common setup or constraints between actions.
      def set_order 
        @customer = Customer.find params[:customer_id]
        @order = Order.find(params[:id])
      end
      
      # Only allow a list of trusted parameters through.
      def order_params
        params.require(:order).permit(:description, :customer_id, :service_id)
      end
      def catch_not_found(e)
        Rails.logger.debug("We had a not found exception.")
        flash.alert = e.to_s
        redirect_to orders_path
      end
########PRIVATE FOR ORDER1
      #PRIVATE FOR ORDERS
    # Use callbacks to share common setup or constraints between actions.
    def set_order1 
      @order = Order.find(params[:id])
      
    end

    # Only allow a list of trusted parameters through.
    def order_params1
      params.require(:order).permit(:description, :customer_id, :service_id)
    end
    def catch_not_found1(e)
      Rails.logger.debug("We had a not found exception.")
      flash.alert = e.to_s
      redirect_to orders_path
    end
end
