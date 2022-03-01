class CartsController < ApplicationController
  before_action :authenticate_user!
  before_action :login_user_id
  def index
    @carts = Cart.where(user_id:  @userId).order("created_at DESC")
    @total_price = 0
    @carts.each do |item|
      @total_price = @total_price + (item.quantity*item.product.price)
    end
  end

  def add
    @oldCart = Cart.where(product_id: params[:id],user_id:  @userId).first
    if @oldCart
      if @oldCart.product.quantity > (@oldCart.quantity)
          @oldCart.increment!(:quantity)
          @oldCart.save
          redirect_to root_path,notice:"#{@oldCart.quantity } * #{@oldCart.product.title} is added to cart"
      else
        redirect_to root_path,notice:"#{@oldCart.product.title} is out of stock"
      end
    else
      @cart = Cart.new(product_id: params[:id],user_id:  @userId,quantity: 1)
      if @cart.product.quantity != 0
        if @cart.save
          redirect_to root_path,notice:"#{@cart.product.title} is added to cart"
        else
          render :new, status: :unprocessable_entity
          # render 'new'
        end
      else
        redirect_to root_path,notice:"#{@cart.product.title} is out of stock"
      end
    end

  end

  def delete 
    @cart = Cart.find(params[:id])
     if @cart.destroy
      flash[:notice] = "#{@cart.product.title} is removed from cart"
      redirect_to action: "index"
    end
  end

  private
  def login_user_id
    @userId = current_user.id
    @userEmail = current_user.email
  end
end
