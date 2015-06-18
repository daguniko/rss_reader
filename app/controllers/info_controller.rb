class InfoController < ApplicationController
  before_action :set_item, only: [:detail]
  def index
    @items = Item.all
  end
  def detail
  end

  private
  def set_item
    @item = Item.find(params[:id])
  end

end
