class OrderMailer < ApplicationMailer
	default :from => 'parth@example.com'

  def order_place_email(user,carts)
    @user = user
    @carts = carts
    mail( :to => @user.email,
    :subject => 'Thanks for signing up for our amazing app' )
  end
end
