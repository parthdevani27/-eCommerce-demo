class CartsController < ApplicationController
  before_action :authenticate_user!
  before_action :login_user_id ,:check_for_cart
  def index
      @carts = @user.cart.cartItems.order("created_at DESC")
      @total_price = 0
      @carts.each do |item|
        @total_price = @total_price + (item.quantity*item.product.price)
      end
  end

  def add
    @product = Product.find(params[:id])
    @oldCart = @user.cart.cartItems.where(product: @product).first
    if @oldCart
      if @oldCart.product.quantity > (@oldCart.quantity)
          @oldCart.increment!(:quantity)
          @oldCart.save
          redirect_to root_path,notice:"#{@oldCart.quantity } * #{@oldCart.product.title} is added to cart"
      else
        redirect_to root_path,notice:"#{@oldCart.product.title} is out of stock"
      end
    else
      @cart = @user.cartItems.new()
      if @product.quantity != 0
          @cart.product = @product
          @cart.quantity = 1
          @cart.save
          redirect_to root_path,notice:"#{@cart.product.title} is added to cart"
      else
        redirect_to root_path,notice:"#{@product.title} is out of stock"
      end
    end

  end

  def delete 
    @cart = CartItem.find(params[:id])
     if @cart.destroy
      flash[:notice] = "#{@cart.product.title} is removed from cart"
      redirect_to action: "index"
    end
  end

  def increment 

    @cartItem = CartItem.find(params[:id])
    if @cartItem.product.quantity > (@cartItem.quantity)
        @cartItem.increment!(:quantity)
        @cartItem.save()
        redirect_back(fallback_location: root_path)
    else
        redirect_back(fallback_location: root_path) 
    end

  end

  def decrement

   @cartItem = CartItem.find(params[:id])  
   if (@cartItem.quantity) > 1 
      @cartItem.decrement!(:quantity)
      @cartItem.save()
      redirect_back(fallback_location: root_path)
    else
      redirect_back(fallback_location: root_path) 
    end  

  end

  private
  def login_user_id
    @user = current_user
  end

  def check_for_cart
    if !Cart.where(user_id: @user.id).first
      @new_cart = Cart.new()
      @new_cart.user = @user
      @new_cart.save()
    end
  end

end
