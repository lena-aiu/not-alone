class ServicesController < ApplicationController
  include ApplicationHelper

  rescue_from ActiveRecord::RecordNotFound, with: :catch_not_found
  before_action :authenticate_user!, except: [:show, :index]
  before_action :is_user_authorized?, except: [:show, :index]
  before_action :set_service, only: [:show, :edit, :update, :destroy]

  helper_method :admin?
  helper_method :intern?
  helper_method :is_user_authorized?

  def index
      @services = Service.all
      @hash = Gmaps4rails.build_markers(@services) do |service, marker|
        marker.lat service.latitude
        marker.lng service.longitude
        marker.infowindow "<a href='https://www.google.com/maps/dir/Current+Location/#{service.address}' target='_blank'>#{service.name}</a>"
      end
  end

  def show
      @hash = Gmaps4rails.build_markers(@service) do |service, marker|
        marker.lat service.latitude
        marker.lng service.longitude
        marker.infowindow "<a href='https://www.google.com/maps/dir/Current+Location/#{service.address}' target='_blank'>#{service.name}</a>"
      end
  end

  def new
    if  current_user.role.include?("administrator") || current_user.role.include?("intern")
      @service = Service.new
    else
      flash.notice = "You are not authorized for that operation."
      redirect_to home_index_path
    end

  end

  def edit
    if  current_user.role.include?("administrator") || current_user.role.include?("intern")
      render :edit
    else
      flash.notice = "You are not authorized for that operation."
      redirect_to home_index_path
    end
  end

  def create
    if  current_user.role.include?("administrator") || current_user.role.include?("intern")
      @service = Service.new(service_params)
    else
      flash.notice = "You are not authorized for that operation."
      redirect_to home_index_path
    end
    @service = Service.new(service_params)
    if @service.save
      flash.notice = "The service record was created successfully."
      redirect_to @service
    else
      flash.now.alert = @service.errors.full_messages.to_sentence
      render :edit
    end

  end

  def update
    if  current_user.role.include?("administrator") || current_user.role.include?("intern")
      @service.update(service_params)
    else
      flash.notice = "You are not authorized for that operation."
      redirect_to home_index_path
    end
    if @service.update(service_params)
      flash.notice = "The service record was updated successfully."
      redirect_to @service
    else
      flash.now.alert = @service.errors.full_messages.to_sentence
      render :edit
    end
  end

  def destroy
    if  current_user.role.include?("administrator") || current_user.role.include?("intern")
      @service.destroy
    else
      flash.notice = "You are not authorized for that operation."
      redirect_to home_index_path
    end
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
end
