class ItemsController < ApplicationController

  def create  
    @list = List.find(params[:list_id])
    @item = @list.items.build(item_params)

    @item.save
    render :layout => false
  end

  def update
    @list = List.find(params[:list_id])
    @item = @list.items.find(params[:id])
    
    @item.update(item_params)
    
    render :nothing => true, :status => :ok
  end

  private
    def item_params
      params.require(:item).permit(:content, :status)
    end
end
