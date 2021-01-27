class HomeController < ApplicationController
  before_action :health, :except => [:index, :about]
  
  helper_method :health_result
  helper_method :health_result2

  def index
  end

  def about
  end

  def health
    # byebug
    # for i in 1..26
    #   if params["x#{i}".to_sym] != nil
    #     return false
    #   end
    # end
    # flash[:error] = "Error: you should answer all questions!"
  end

  def results
    # byebug
    correct = 0
    for i in 1..4
      if params["x#{i}".to_sym] == "no"
        correct += 1
      end 
    end
    for i in 5..8
      if params["x#{i}".to_sym] == "yes"
        correct += 1
      end
    end
    for i in 9..26
      if params["x#{i}".to_sym] == "yes"
        correct += 5
      end
    end
    # puts correct
    @correct_answer = correct
  end

  private

  def health_result
    # byebug
    for i in 1..26
      if params["x#{i}".to_sym] == nil
        flash[:notice] = "We couldn't compute your score, because your quiz answers were incomplete"
        return true
      end
    end
    return false
  end
end
