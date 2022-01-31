class Public::CustomersController < ApplicationController
  
  def show
    @customer = current_customer
  end
  
  def edit
    @customer = Customer.find(params[:id])
  end
  
  def update
    @customer = current_customer
    if @customer.update(customer_params)
      redirect_to public_customer_path
    end
  end
  
private

def customer_params
  params.require(:customer).permit(:last_name, :last_name_kana, :first_name, :first_name_kana, :postal_code, :address, :telephone_number, :email)
end

end

