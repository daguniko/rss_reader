class InfoController < ApplicationController
  def index
    @items = Item.all
  end
end
