class Public::OrdersController < ApplicationController
   before_action :authenticate_customer!
   before_action :request_post?, only: [:confirm]
   before_action :order_new?, only: [:new]

  def index
    # 現在、ログインしているユーザの情報を表示する。
    @orders = current_customer.orders
  end

  def show
    @order = Order.find(params[:id]) #orderの情報を特定
    @order_details = @order.order_details ##特定した@orderからorder_detailsの情報を全部取得
  end

  def new
    @customer = current_customer
    @order = Order.new
  #   @i = current_customer.cart_items
  #   @all = Item.all
  #   @i.each do |item|
  #     @all = @all.where.not(id: item.item_id)
  #   end
  #   @item_random = @all.order("RANDOM()").limit(2)
  #   @address = Address.new
  end

  def confirm
    @order = Order.new(order_params)
  # new 画面から渡ってきたデータを @order に入れます
    if params[:order][:address_number] == "0" #現在の住所が選ばれたら
  # view で定義している プロパティ名がselect_address が"1"だったときにこの処理を実行します
  # form_with で @order で送っているので、order に紐付いたselect_addresse となります。
      @order.name = current_customer.first_name + current_customer.last_name
      @order.address = current_customer.address
      @order.postal_code = current_customer.postal_code

    elsif params[:order][:address_number] == "1"#登録済みの住所が選ばれたら
    # view で定義している address_number が"１"だったときにこの処理を実行します
      @address = Address.find(params[:order][:address_id])
      @order.postal_code = @address.postal_code
      @order.address = @address.address
      @order.name = @address.name

    elsif params[:order][:address_number] == "2"#新しい住所の場合
      # view で定義している address_number が"3"だったときにこの処理を実行します
      @address_new = current_customer.addresses.new(address_params)
      if address_new.save
        @order.postal_code = @address.postal_code #上記で代入された郵便番号をorderに代入
        @order.name = @address.name #上記で代入された宛名をorderに代入
        @order.address = @address.address #上記で代入された住所をorderに代入

      else
        render :new
# ここに渡ってくるデータはユーザーで新規追加してもらうので、入力不足の場合は new に戻します
      end
    end
      @cart_items = current_customer.cart_items.all # カートアイテムの情報をユーザーに確認してもらうために使用します
      @total = @cart_items.sum{ |cart_item| cart_item.item.price* cart_item.amount* 1.1 + 800}.floor
# 合計金額を出す処理です sum_price はモデルで定義したメソッドです
  end

  def create
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @order.save
    # ここに至るまでの間にチェックは済ませていますが、念の為IF文で分岐させています
    current_customer.cart_items.each do |cart_item|
      # 取り出したカートアイテムの数繰り返します
      # order_detailにも一緒にデータを保存する必要があるのでここで保存します
      @order_detail = OrderDetail.new
      @order_detail.item_id = cart_item.item_id
      @order_detail.order_id = @order.id
      @order_detail.amount = cart_item.amount
      # 購入が完了したらカート情報は削除するのでこちらに保存します
      @order_detail.price_including_tax = (cart_item.item.price * 1.1).floor
      # カート情報を削除するので item との紐付けが切れる前に保存します
      @order_detail.save
    end
    current_customer.cart_items.destroy_all #カートの中身を削除
    # ユーザーに関連するカートのデータ(購入したデータ)をすべて削除します(カートを空にする)
    redirect_to public_oreders_complete_path
  end

  private
  
  def order_new?
    redirect_to public_cart_items_path, notice: "カートに商品を入れてください。" if current_customer.cart_items.blank?
  end

  def request_post?
    redirect_to new_public_order_path, notice: "もう一度最初から入力してください。" unless request.post?
  end

  def order_params
    params.require(:order).permit(:payment_method, :postal_code, :address, :total_payment, :shipping_cost, :name)
  end

  def address_params
  params.require(:order).permit(:name, :address, :postal_code)
  end

end
