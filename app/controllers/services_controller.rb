class ServicesController < ApplicationController
  include ApplicationHelper

  rescue_from ActiveRecord::RecordNotFound, with: :catch_not_found
  before_action :authenticate_user!, except: [:show, :index]
  before_action :is_user_authorized?, except: [:show, :index]
  before_action :set_service, only: [:show, :edit, :update, :destroy]

  helper_method :admin?
  helper_method :intern?
  helper_method :is_user_authorized?

  # GET /services
  # GET /services.json
  def index
    if current_user.role.nil? || current_user.role.include?("volunteer")
      # flash.notice = "You are not authorized for that operation."
      # redirect_to home_index_path
      @services = Service.all
      @hash = Gmaps4rails.build_markers(@services) do |service, marker|
        marker.lat service.latitude
        marker.lng service.longitude
        marker.infowindow "<a href='https://www.google.com/maps/dir/Current+Location/#{service.address}' target='_blank'>#{service.name}</a>"
      end
    elsif current_user.role.include?("administrator") || current_user.role.include?("intern")
      @services = Service.all
      @hash = Gmaps4rails.build_markers(@services) do |service, marker|
        marker.lat service.latitude
        marker.lng service.longitude
        marker.infowindow "<a href='https://www.google.com/maps/dir/Current+Location/#{service.address}' target='_blank'>#{service.name}</a>"
      end
    else
      flash.notice = "You are not authorized for that operation."
      redirect_to home_index_path
    end
    # if current_user.role.nil? || current_user.role.include?("volunteer") || current_user.role.include?("administrator") || current_user.role.include?("intern")
    #   @services = Service.all
    #   @hash = Gmaps4rails.build_markers(@services) do |service, marker|
    #     marker.lat service.latitude
    #     marker.lng service.longitude
    #     marker.infowindow "<a href='https://www.google.com/maps/dir/Current+Location/#{service.address}' target='_blank'>#{service.name}</a>"
    #   end
    # end
  end

  # GET /services/1
  # GET /services/1.json
  def show
    if current_user.role.nil? || current_user.role.include?("volunteer")
      flash.notice = "You are not authorized for that operation."
      redirect_to home_index_path
    elsif current_user.role.include?("administrator") || current_user.role.include?("intern")
      @hash = Gmaps4rails.build_markers(@service) do |service, marker|
        marker.lat service.latitude
        marker.lng service.longitude
        marker.infowindow "<a href='https://www.google.com/maps/dir/Current+Location/#{service.address}' target='_blank'>#{service.name}</a>"
      end
      render :show
    else
      flash.notice = "You are not authorized for that operation."
      redirect_to home_index_path
    end
    # @hash = Gmaps4rails.build_markers(@service) do |service, marker|
    #   marker.lat service.latitude
    #   marker.lng service.longitude
    #   marker.infowindow "<a href='https://www.google.com/maps/dir/Current+Location/#{service.address}' target='_blank'>#{service.name}</a>"
    # end
  end

  # GET /serivices/new
  def new
    # @service = Service.new
    if current_user.role.nil?
      flash.notice = "You are not authorized for that operation."
      redirect_to home_index_path
    elsif current_user.role.include?("administrator") || current_user.role.include?("intern")
      @service = Service.new
    else
      flash.notice = "You are not authorized for that operation."
      redirect_to home_index_path
    end

  end

  # GET /services/1/edit
  def edit
    if current_user.role.nil?
      flash.notice = "You are not authorized for that operation."
      redirect_to home_index_path
    elsif current_user.role.include?("administrator") || current_user.role.include?("intern")
      render :edit
    else
      flash.notice = "You are not authorized for that operation."
      redirect_to home_index_path
    end
  end

  # POST /services
  # POST /services.json
  def create
    # @service = Service.new(service_params)
    # if @service.save
    #   if params[:service][:picture].present?
    #     @service.picture.attach(params[:service][:picture])
    #   end
    #   flash.notice = "The service record was created successfully."
    #   redirect_to @service
    # else
    #   flash.now.alert = @service.errors.full_messages.to_sentence
    #   render :edit
    # end

    # new
    if current_user.role.nil?
      flash.notice = "You are not authorized for that operation."
      redirect_to home_index_path
    elsif current_user.role.include?("administrator") || current_user.role.include?("intern")
      # @category = Category.new(category_params)

      @service = Service.new(service_params)
      if @service.save
        if params[:service][:picture].present?
          @service.picture.attach(params[:service][:picture])
        end
        flash.notice = "The service record was created successfully."
        redirect_to @service
      else
        flash.now.alert = @service.errors.full_messages.to_sentence
        render :edit
      end

    else
      flash.notice = "You are not authorized for that operation."
      redirect_to home_index_path
    end

    # @category = Category.new(category_params)
    # if @category.save
    #   flash.notice = "The customer record was created successfully."
    #   redirect_to @category
    # else
    #   flash.now.alert = @category.errors.full_messages.to_sentence
    #   render :new
    # end
    # new

    @service = Service.new(service_params)
    if @service.save
      if params[:service][:picture].present?
        @service.picture.attach(params[:service][:picture])
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
    # if @service.update(service_params)
    #   if params[:service][:picture].present?
    #     @service.picture.attach(params[:service][:picture])
    #   end
    #   flash.notice = "The service record was updated successfully."
    #   redirect_to @service
    # else
    #   flash.now.alert = @service.errors.full_messages.to_sentence
    #   render :edit
    # end

# new
if current_user.role.nil?
  flash.notice = "You are not authorized for that operation."
  redirect_to home_index_path
elsif current_user.role.include?("administrator") || current_user.role.include?("intern")
  # @category.update(category_params)
  if @service.update(service_params)
    if params[:service][:picture].present?
      @service.picture.attach(params[:service][:picture])
    end
    flash.notice = "The service record was updated successfully."
    redirect_to @service
  else
    flash.now.alert = @service.errors.full_messages.to_sentence
    render :edit
  end

else
  flash.notice = "You are not authorized for that operation."
  redirect_to home_index_path
end

# if @category.update(category_params)
#   flash.notice = "The customer record was updated successfully."
#   redirect_to @category
# else
#   flash.now.alert = @category.errors.full_messages.to_sentence
#   render :edit
# end

if @service.update(service_params)
  if params[:service][:picture].present?
    @service.picture.attach(params[:service][:picture])
  end
  flash.notice = "The service record was updated successfully."
  redirect_to @service
else
  flash.now.alert = @service.errors.full_messages.to_sentence
  render :edit
end


# new
  end

  # DELETE /customers/1
  # DELETE /customers/1.json
  def destroy
    # @service.destroy
    # respond_to do |format|
    #   format.html { redirect_to services_url, notice: 'Service was successfully destroyed.' }
    #   format.json { head :no_content }
    # end

    if current_user.role.nil?
      flash.notice = "You are not authorized for that operation."
      redirect_to home_index_path
    elsif current_user.role.include?("administrator") || current_user.role.include?("intern")
      # @category.destroy
      @service.destroy
      respond_to do |format|
        format.html { redirect_to services_url, notice: 'Service was successfully destroyed.' }
        format.json { head :no_content }
      end
    else
      flash.notice = "You are not authorized for that operation."
      redirect_to home_index_path
    end
    # @category.destroy
    # respond_to do |format|
    #   format.html { redirect_to categories_path, notice: 'Category was successfully destroyed.' }
    #   format.json { head :no_content }
    # end
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
