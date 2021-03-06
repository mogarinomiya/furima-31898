class ItemsController < ApplicationController
  def index
    @items = Items.all
  end

  def item_params
    params.require(:message).permit(:content, :image).merge(user_id: current_user.id)
  end
end
