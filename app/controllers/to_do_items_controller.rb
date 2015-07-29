class ToDoItemsController < ApplicationController

  def new
    list = List.find params[:id]
    @item = list.items.new

    render partial: 'new'
  end

  def create
    @item = Item.new item_params
    @item.save
  end

  def update
    item = Item.find params[:id]
    item.mark

    render json: item
  end

  def move
    @item = Item.find params[:id]
    @item.insert_at params[:position].to_i

    render nothing: true
  end

  def statistic
    completed = Item.where('completed_at >= ? AND completed_at <= ?',
      Date.today.to_time.beginning_of_day,
      Date.today.to_time.end_of_day).count
    remaining = Item.incompleted.count
    statistic = Hash(completed: completed, remaining: remaining)

    daily_statistic = DailyStatisticNotifier.new statistic
    Notifier.statistic(daily_statistic).deliver
    flash[:notice] = 'Email has been sent'
  end

  private

  def item_params
    params.require(:item).permit(:text, :list_id)
  end

end