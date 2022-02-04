class Public::AddressesController < ApplicationController

    def index
        @addresses = current_customer.addresses
        @address = Address.new
    end
    
    def create
        @address = Address.new(address_params)
        @address.customer_id = current_customer.id
        if @address.save
            redirect_to  public_addresses_path
        end
    end
    
    def edit
        @address = Address.find(params[:id])
    end
    
    def update
        @address = Address.find(params[:id])
        @address.update(address_params)
    end
    
    def destroy
        @address = Address.find(params[:id])
        @address.destroy
        redirect_to public_addresses_path
    end


    private
    
    def address_params
        params.require(:address).permit(:customer_id, :name, :postal_code, :address)
    end

end
