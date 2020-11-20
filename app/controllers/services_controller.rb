class ServicesController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :catch_not_found
    layout 'service_layout'
    before_action :set_service, only: [:show, :edit, :update, :destroy]
  
    # GET /services
    # GET /services.json
    def index
      #byebug
      @services = Service.all
    end
  
    # GET /services/1
    # GET /services/1.json
    def show
      #@picture = Service.find(params[:picture])
      #@picture = Service.find.params[:picture]
    end
  
    # GET /serivices/new
    def new
      @service = Service.new
    end
  
    # GET /services/1/edit
    def edit
      #byebug
      #@picture = Service.find(params[:picture])
    end
  
    # POST /services
    # POST /services.json
    def create
      @service = Service.new(service_params)
      if @service.save
        if params[:service][:picture].present? 
          @service.picture.attach(params[:service][:picture])
          #@service.picture.attach(@picture)
        end
        flash.notice = "The service record was created successfully."
        redirect_to @service
      else
        flash.now.alert = @service.errors.full_messages.to_sentence
        render :new  
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
    def update
      if @service.update(service_params)
        # byebug
        if params[:service][:picture].present?
          # byebug 
          @service.picture.attach(params[:service][:picture])
          #@service.picture.attach(@picture)
        end
        flash.notice = "The service record was updated successfully."
        redirect_to @service
      else
        # byebug
        flash.now.alert = @service.errors.full_messages.to_sentence
        render :edit
      end
      #params[:service][:pictures].each do |picture| more than one
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
    def destroy
      @service.destroy
      respond_to do |format|
        format.html { redirect_to services_url, notice: 'Service was successfully destroyed.' }
        format.json { head :no_content }
      end
    end
  
    private
      # Use callbacks to share common setup or constraints between actions.
      def set_service
        @service = Service.find(params[:id])
        #@picture = Service.find(params[:picture])        
      end
  
      # Only allow a list of trusted parameters through.
      def service_params
        params.require(:service).permit(:name, :description, :kind, :phone_number, :url, :picture)
      end
      def catch_not_found(e)
        Rails.logger.debug("We had a not found exception.")
        flash.alert = e.to_s
        redirect_to services_path
      end
end

