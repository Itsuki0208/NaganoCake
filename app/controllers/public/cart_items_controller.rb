class Public::CartItemsController < ApplicationController

     before_action :authenticate_customer!

    def index
        @cart_items = current_customer.cart_items
    end

    def create
        @cart_item = CartItem.new(cart_item_params)
        @cart_item.customer_id = current_customer.id
        @cart_item.item_id = params[:item_id]
        @cart_item.save
        redirect_to public_cart_items_path
    end

    def update
        @cart_item = CartItem.find(params[:id])
        #@cart.units += cart_params[:units].to_i
        @cart_item.update(cart_item_params)
        redirect_to customers_cart_items_path
    end

    def destroy
        @cart_item = CartItem.find(params[:id])
        @cart_item.destroy
        redirect_to public_cart_items_path
    end

    private

    def cart_item_params
     params.permit(:item_id, :customer_id, :amount)
    end

end
