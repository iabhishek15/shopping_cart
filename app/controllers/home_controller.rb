class HomeController < ApplicationController
  def index
  end

  def search
    @products = Product.paginate(page: params[:page], per_page:8)
    if request.post?
      data = "%#{params[:data]}%"
      @products = Product.all.where(
        "name LIKE ? or
        price LIKE ? or
        operating_system LIKE ? or
        storage LIKE ? or
        display LIKE ? or
        quantity LIKE ?
        ",data, data, data, data, data, data).paginate(page: params[:page], per_page: 8)
      if @products.count == 0
        flash[:alert] = "No result found"
        flash[:notice] = nil
      else
        flash[:notice] = "#{@products.count} result found!"
        flash[:alert] = nil
      end
    end
  end

  def shop
    @products = Product.paginate(page: params[:page], per_page: 8)
  end
end
