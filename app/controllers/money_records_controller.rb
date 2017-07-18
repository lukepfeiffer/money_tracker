class MoneyRecordsController < ApplicationController

  require 'will_paginate/collection'

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

  expose :filter_active_records do
    filter_dates
    @category = params[:category_id].present? ? Category.find(params[:category_id].to_i) : nil
    MoneyRecord.filter(current_user, @start_date, @end_date, @category)
  end

  expose :filtered_money_records do
    if params[:active] == 'true'
      paginate_and_order(active_records)
    elsif params[:filter] == 'all'
      paginate_and_order(money_records)
    elsif params[:category_id].blank? && params[:start_date].blank? && params[:end_date].blank?
      paginate_and_order(money_records)
    elsif params[:filter].include?('other')
      paginate_and_order(filter_active_records)
    elsif params[:filter].nil?
      paginate_and_order(money_records)
    end
  end

  def paginate_and_order(records)
    if params[:active] == 'true' || params[:category_id].blank?
      records.paginate(page: params[:page], per_page: 15)
    elsif records == MoneyRecord.last
      records = []
    else
      records.paginate(page: params[:page], per_page: 15).order(created_at: 'DESC')
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
    if params[:category_id].present?
      @category = Category.find(params[:category_id])
    end
    filter_dates
  end

  def update
    if money_record.update(money_record_params)
      render partial: 'records_table', locals: {record: money_record}
    else
      head :no_content
    end
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

  def filter_dates
    @start_date = params[:start_date].present? ? params[:start_date].to_date : Date.today.beginning_of_month
    @end_date = params[:end_date].present? ? params[:end_date].to_date : Date.today.end_of_month
  end

  private

  def money_record_params
    params.require(:money_record).permit(
      :amount,
      :adjusted_date,
      :category_id
    )
  end
end
