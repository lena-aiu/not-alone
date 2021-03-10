class ServicesController < ApplicationController
  include ApplicationHelper
  rescue_from ActiveRecord::RecordNotFound, with: :catch_not_found
  #layout 'service_layout'
  before_action :authenticate_user!, except: [:show, :index]
  before_action :is_user_authorized?, except: [:show, :index]
  before_action :set_service, only: [:show, :edit, :update, :destroy]
  
  helper_method :admin?
  helper_method :intern?
  helper_method :is_user_authorized?

  # GET /services
  # GET /services.json
  def index
    if params[:search].present?
      #services = Service.search_name(params[:query])
      byebug
      @services = Service.near(params[:search], 2, :order => :distance) 
    else
      byebug
      @services = Service.all
    end

    @services = Service.all
    @hash = Gmaps4rails.build_markers(@services) do |service, marker|
      marker.lat service.latitude
      marker.lng service.longitude
      marker.infowindow "<a href='https://www.google.com/maps/dir/Current+Location/#{service.address}' targe='_blank'>#{service.name}</a>"
    end
  end

  # GET /services/1
  # GET /services/1.json
  def show
    #@picture = Service.find(params[:picture])
    #@picture = Service.find.params[:picture]
    @hash = Gmaps4rails.build_markers(@service) do |service, marker|
      marker.lat service.latitude
      marker.lng service.longitude
      marker.infowindow "<a href='https://www.google.com/maps/dir/Current+Location/#{service.address}' targe='_blank'>#{service.name}</a>"
    end
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
      params.require(:service).permit(:name, :description, :kind, :phone_number, :url, :picture, :latitude, :longitude, :street, :city, :state, :zip)
    end

    def catch_not_found(e)
      Rails.logger.debug("We had a not found exception.")
      flash.alert = e.to_s
      redirect_to services_path
    end

    def admin?
      if current_user.nil?
        return false
      end
      if current_user.role.nil?
        return false
      end
      current_user.role.include?("administrator")
    end

    def intern?
      if current_user.nil?
        return false
      end
      if current_user.role.nil?
        return false
      end
      current_user.role.include?("intern")
    end
end
