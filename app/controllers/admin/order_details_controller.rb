class Admin::OrderDetailsController < ApplicationController
	
	def update
		@order_detail = OrderDetail.find(params[:id])
		@order = @order_detail.order #注文商品から注文テーブルの呼び出し（何度も呼び出すのは処理が増える為）
		@order_detail.update(order_detail_params) #ステータスの更新
		if @order_detail.making_status == "製作中" ##製作ステータスが「製作作中」なら入る
			 @order.update(status: 2) #注文ステータスを「製作中」　に更新
			 
		else @order.order_details = @order.order_details.where(making_status: "製作完了")
			@order.update(status: 3)
		end	
		redirect_to admin_orders_path
	end
	
	private
	
	def order_detail_params
		params.require(:order_detail).permit(:making_status)
	end
	
end