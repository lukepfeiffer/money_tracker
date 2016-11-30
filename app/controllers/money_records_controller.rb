class MoneyRecordsController < ApplicationController

  expose :category
  expose :money_record

  expose :money_records do
    records = []
    records << current_user.money_records
    records.first
  end

  expose :active_records do
    records = []
    categories = current_user.categories.active
    categories.each do |category|
      category.money_records.each do |record|
        records << record
      end
    end
    records
  end

  expose :filtered_money_records do
    if params[:filter] == 'all'
      money_records
    elsif params[:filter] == 'active'
      active_records
    elsif params[:filter].nil?
      filter_active_records
    end
  end

  expose :active_categories do
    current_user.categories.active.order(created_at: 'DESC')
  end
  expose :archived_categories do
    current_user.categories.archived.order(created_at: 'DESC')
  end

  def index
    if current_user.nil?
      redirect_to :root
    end
    filter_dates
  end


  def create
    money_record = MoneyRecord.new(money_record_params)
    money_record.category_id = params[:category_id]
    category = Category.find(params[:category_id])
    adjust_category_amount(category, money_record)
    if money_record.save
      render partial: 'categories/category_container', locals: {categories: category}
    else
      head :no_content
    end
  end

  def adjust_category_amount(category, money_record)
    category.update(amount: category.amount + money_record.amount)
  end

  def filter_active_records
    filter_dates
    @category = params[:category].present? ? Category.find(id: params[:category]) : nil
    MoneyRecord.filter(current_user, @start_date, @end_date, @category)
  end

  def filter_dates
    @start_date = params[:start_date].present? ? params[:start_date].to_date : filtered_money_records.first.created_at.to_date
    @end_date = params[:end_date].present? ? params[:end_date].to_date : filtered_money_records.last.created_at.to_date
  end

  private

  def money_record_params
    params.require(:money_record).permit(
      :amount,
      :category_id
    )
  end
end
