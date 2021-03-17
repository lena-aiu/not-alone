class Contact < MailForm::Base
  attribute :name,     :validate => true
  attribute :email,    :validate => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
  attribute :message,  :validate => true
  attribute :nickname, :captcha => true   
  def headers
    {
      #this is the subject for the email generated
      :subject => "Contact Form",
      :to => "adi_111@icloud.com",
      :from => %("#{name}" <#{email}>)
    }
  end
end