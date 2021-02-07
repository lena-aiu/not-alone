class VideosController < InheritedResources::Base
  rescue_from ActiveRecord::RecordNotFound, with: :catch_not_found
  include ApplicationHelper
  #layout 'video_layout'
  before_action :authenticate_user!, except: [:show, :index]
  before_action :is_user_authorized?, except: [:show, :index]
  before_action :set_video, only: [:show, :edit, :update, :destroy]
  
  helper_method :admin?
  helper_method :intern?
  helper_method :is_user_authorized?
  

  def video_params
    params.require(:video).permit(:title, :description, :clip)#, :thumbnail)
  end
  # GET /videos
  # GET /videos.json
  def index
    @videos = Video.all
  end

  # GET /videos/1
  # GET /videos/1.json
  def show
    #@clip = Video.find(params[:clip])
    #@clip = Video.find.params[:clip]
  end

  # GET /videos/new
  def new
    @video = Video.new
    if current_user.role.nil?
      return false
      redirect_to root_path
    end
  end

  # GET /videos/1/edit
  def edit
    #byebug
    #@clip = Video.find(params[:clip])
  end

  # POST /videos
  # POST /videos.json
  def create
    @video = Video.new(video_params)
    if @video.save
      if params[:video][:clip].present?
        @video.clip.attach(params[:video][:clip])
        #@video.picture.attach(@picture)
      end
      flash.notice = "The video record was created successfully."
      redirect_to @video
    else
      flash.now.alert = @video.errors.full_messages.to_sentence
      render :new
    end

  end

  # PATCH/PUT /videos/1
  # PATCH/PUT /videos/1.json
  def update
    if @video.update(video_params)
      # byebug
      if params[:video][:clip].present?
        # byebug
        @video.clip.attach(params[:video][:clip])
        #@video.picture.attach(@picture)
      end
      flash.notice = "The video record was updated successfully."
      redirect_to @video
    else
      # byebug
      flash.now.alert = @video.errors.full_messages.to_sentence
      render :edit
    end
  end

  # DELETE /videos/1
  # DELETE /videos/1.json
  def destroy
    @video.destroy
    respond_to do |format|
      format.html { redirect_to videos_url, notice: 'Video was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_video
      @video = Video.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def video_params
      params.require(:video).permit(:title, :description, :clip)
    end

    def catch_not_found(e)
      Rails.logger.debug("We had a not found exception.")
      flash.alert = e.to_s
      redirect_to videos_path
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