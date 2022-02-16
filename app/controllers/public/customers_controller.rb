class Public::CustomersController < ApplicationController

  def show
    @customer = current_customer
  end

  def edit
    @customer = current_customer
  end

  def update
    @customer = current_customer
    @customer.update(customer_params)
    redirect_to public_customers_path
  end
  
  def unsubscribe
  end

  def withdrawl
    #withdrawl_activeカラムをtrueに変更することにより削除フラグを立てる
    current_customer.update(withdrawl_active: true, status: 1 )
    # セッション情報を全て削除します。
    reset_session
    redirect_to root_path
  end
  


private

def customer_params
  params.require(:customer).permit(:last_name, :last_name_kana, :first_name, :first_name_kana, :postal_code, :address, :telephone_number, :email, :status)
end

end

