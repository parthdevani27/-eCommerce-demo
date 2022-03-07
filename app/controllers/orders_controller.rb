class OrdersController < ApplicationController
  before_action :authenticate_user!,:login_user_id
  def index

    @orders = @user.orders.order("created_at DESC")

  end

  def add
    @cartItems = @user.cart.cartItems
    @cartItems.each do |item|
      if item.product.quantity >=  item.quantity
        @order = Order.new()
        @order.product_id = item.product.id
        @order.user_id = @userId
        @order.total_amount = item.product.price 
        @order.quantity = item.quantity
        @order.status = 'pending'
        @order.save
        @product = Product.find(item.product.id)
        @product.quantity = @product.quantity - item.quantity
        @product.save
        flash[:notice] = "Your order is placed"
      else 
        flash[:alert] = "#{item.product.title} is out of stock now so that order not placed"
      end 
    end
     OrderMailer.order_place_email(@user,@cartItems).deliver
    @user.cart.destroy
    redirect_to   action: "index"
  end

  private
  def login_user_id
    @userId = current_user.id
    @user = current_user
  end
end
