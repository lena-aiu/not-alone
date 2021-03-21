class ContactsController < ApplicationController
  def index
    @contact = Contact.new
  end

  def new
    @contact = Contact.new
  end
  def create
    @contact = Contact.new(contact_params)
    @contact.request = request 
    if @contact.deliver
      flash.now[:notice] = 'Thank you for your message. We will contact you soon!'
      redirect_to root_path
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

