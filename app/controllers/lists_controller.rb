class ListsController < ApplicationController

  def index
    @lists = List.order("created_at DESC").all
    @list = List.new

    respond_to do |f|
      f.html {}
    end 
  end

  def create
    @list = List.new(list_params)
    @list.save

    render :layout => false
  end

  def destroy
    @list = List.find(params[:id])
    @list.destroy

    render :nothing =>true, :status => 204
  end

  def show
    @list = List.find(params[:id])
    @items = @list.items.order("created_at DESC").all
    @item = Item.new
  end

  private
    def list_params
      params.require(:list).permit(:name)
    end
end
