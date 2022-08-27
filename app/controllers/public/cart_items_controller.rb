class Public::CartItemsController < ApplicationController

  def index
    @cart_items = CartItem.all
    @cart_items = current_customer.cart_items
    @total = 0

  end

  def update
    @cart_item = CartItem.find(params[:id])
    @cart_item.update(cart_item_params)
    redirect_to public_cart_items_path
  end

  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    redirect_to public_cart_items_path
  end

  def destroy_all
    @cart_items = CartItem.all
    @cart_items = current_customer.cart_items
    current_customer.cart_items.destroy_all
    redirect_to public_cart_items_path
  end

  def create
      if current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id]).present?
         cart_item = current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id])
         cart_item.amount += params[:cart_item][:amount].to_i
         cart_item.save
         redirect_to public_cart_items_path
      else
        @cart_item = CartItem.new(cart_item_params)
        @cart_item.customer_id = current_customer.id
        @cart_item.save
        redirect_to public_cart_items_path
      end
  end

  private

  def cart_item_params
      params.require(:cart_item).permit(:item_id, :amount, :customer_id)
  end

end
