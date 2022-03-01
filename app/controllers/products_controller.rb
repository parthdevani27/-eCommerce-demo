class ProductsController < ApplicationController
    before_action :authenticate_user!, except: [:view,:index]
   def index
    @products = Product.where(active: "active").order("created_at DESC")
  end

  def view
    @product = find_product(params[:id])
  end

  private
    def find_product(id)
      return Product.find(id)
    end
end
