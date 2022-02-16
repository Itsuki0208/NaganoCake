class Admin::HomesController < ApplicationController
  def top
   from = Date.current.beginning_of_day
   to = Date.current.end_of_day
   @order = Order.where(created_at: from..to)
  end
end
