class UserRollesController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :catch_not_found

    before_action :set_user_rolle, only: [:edit, :update, :destroy]
    before_action :authenticate_user!

    helper_method :admin?
    helper_method :intern?
end
