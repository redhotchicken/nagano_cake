class Public::CartItemsController < ApplicationController

  def index
    @cart_items = CartItem.all
    @total = 0
  end

  def update
    @cart_item.id = current_customer.id
    @cart_item.update
  end

  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
  end

  def destroy_all
    @cart_items = CartItem.all
    @cart_items.destroy_all
  end

  def create
    @cart_item = CartItem.new(cart_item_params)
    @cart_item.id = current_customer.id
    @cart_item.save
  end

  private

  def cart_item_params
      params.require(:cart_item).permit(:item_id, :amount)
  end

end
