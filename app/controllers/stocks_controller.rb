class StocksController < ApplicationController

  def search
    if params[:stock].blank?
      flash.now[:danger] = "Empty search query"
    else
      @stock = Stock.new_from_lookup(params[:stock])
      flash.now[:danger] = "Wrong symbol" unless @stock
    end
    render partial: 'users/result'
  end

end


