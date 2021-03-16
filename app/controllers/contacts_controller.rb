class ContactsController < ApplicationController
  def index
    @contact = Contact.new
    #@contact = Contact.all
    #render :create
  end

  def new
    @contact = Contact.new
  end
  def create
    @contact = Contact.new(params[:contact])
    @contact.request = request 
    if @contact.deliver
      flash.now[:notice] = 'Thank you for your message. We will contact you soon!'
    else 
      flash.now[:error] = 'Can not send your message.'
      render :new
    end
  end
  private
  def contact_params
     params.require(:contact).permit(:name, :email, :message, :nickname)
  end
end

# def show
#   @contact = Contact.new
# end

# def edit
#   render :create
# end

# def update
#   render :create
# end

# def destroy
#   render :create
# end

