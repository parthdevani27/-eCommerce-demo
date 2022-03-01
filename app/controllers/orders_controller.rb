class OrdersController < ApplicationController
  before_action :authenticate_user!,:login_user_id
  def index
    @orders = Order.where(user_id:  @userId).order("created_at DESC")
  end

  def add
    @carts = Cart.where(user_id:  @userId)
    @carts.each do |item|
      if item.product.quantity >=  item.quantity
        @order = Order.new(product_id: item.product.id,user_id:  @userId,total_amount: item.product.price ,quantity:item.quantity)
        @order.save
        @product = Product.find(item.product.id)
        @product.quantity = @product.quantity - item.quantity
        @product.save
        flash[:notice] = "Your order is placed"
      else 
        flash[:alert] = "#{item.product.title} is out of stock now so that order not placed"
      end 
    end
     OrderMailer.order_place_email(@user,@carts).deliver
    @carts.destroy_all
    redirect_to   action: "index"
  end

  private
  def login_user_id
    @userId = current_user.id
    @user = current_user
  end
end
