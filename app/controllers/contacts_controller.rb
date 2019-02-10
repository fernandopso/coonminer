class ContactsController < ApplicationController

  before_action :authenticate_user!, :require_admin, only: :index

  layout "devise"

  def index
    @contats = Contact.created_at_desc
  end

  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(contact_params)
    if @contact.save
      redirect_to success_contacts_path
    else
      render :new
    end
  end

  def success
  end

  private

  def contact_params
    params.require(:contact).permit(:name, :email, :message)
  end
end
