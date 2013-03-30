class UserMailer < ActionMailer::Base
  default :from => "notifications@example.com"
  
  def welcome_email(user)
    mail(:to => user.email, :subject => "Invitation Request Received")
  end

  def expire_email(user)
    mail(:to => user.email, :subject => "Subscription Cancelled")
  end
end