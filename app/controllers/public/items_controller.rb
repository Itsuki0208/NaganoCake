class Public::ItemsController < ApplicationController
  
  def index
    @items = Item.all
    @search = Item.ransack(params[:q])
    @item_all = @search.result
  end
  
  def show
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
  end
  
end