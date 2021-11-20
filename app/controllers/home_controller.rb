class HomeController < ApplicationController
  def index
  end

  def shop
    @products = Product.paginate(page: params[:page], per_page: 8)
  end
end
