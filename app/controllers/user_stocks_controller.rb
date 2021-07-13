class UserStocksController < ApplicationController
  def create
    # if params[:ticker] in current_user.stocks
    stock = Stock.check_db(params[:ticker])
    if stock.blank?
      stock = Stock.new_lookup(params[:ticker])
      stock.save
    end
      @user_stock = UserStock.create(user: current_user, stock: stock)
      flash.now[:notice] = "Stock #{stock.name} was successfully added to your portfolio"
      redirect_to my_portfolio_path
  
  end
end
