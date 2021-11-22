class CartController < ApplicationController
  def index
    @orders = User.find(current_user.id).orders.paginate(page: params[:page], per_page: 4)
    if request.post?
      order = Order.find(params[:id])
      order.update(:quantity => params[:quantity])
      redirect_to cart_path
    end
  end

  def update
  end

  def delete
    order = Order.find(params[:id].to_i)
    order.delete
    redirect_to cart_path
  end


  def add
    if request.post?
      current_user
      order = Order.create({
          :user_id => current_user.id,
          :product_id => params[:id].to_i,
          :quantity => 1
      })
      redirect_to shop_path
    end
  end
end
