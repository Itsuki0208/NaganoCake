class Admin::OrdersController < ApplicationController
  

  def index
    @search = Order.ransack(params[:q])
    @orders = @search.result
  end

  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details
  end

  def update
    @order = Order.find(params[:id]) #注文詳細の特定
  	@order_details = @order.order_details #注文から紐付く商品の取得
  	@order.update(order_params) #注文ステータスの更新

 	  if @order.status == "入金確認" #注文ステータスが入金確認なら下の事をする
	     @order_details.each do |order_detail|
        order_detail.make_status = "製作待ち"
        order_detail.save
      end
	     #製作ステータスを「製作待ちに」　更新
	     #もし、ステータスが入金確認であれば、order.detailsを全て、制作待ちで更新する。
	  end
  		 redirect_to  admin_order_path(@order) #注文詳細に遷移
  end
    # こっちでも可能
    # emunの変換前取得している
  	# if @order.read_attribute_before_type_cast(:order_status) == 1
  	# 	@order_items.each do |order_item|
  	# 	order_item.update(making_status: 1)
  	# 	end
   #  end
  private

  def order_params
  	params.require(:order).permit(:status)
  end

end
