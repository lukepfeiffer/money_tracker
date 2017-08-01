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
    categories = current_user.categories.active
    categories.each_with_object( [] ) do |category, records|
      category.money_records.each do |record|
        records << record
      end
    end
  end

  expose :filtered_money_records do
    filter_records_by_date(filter_records)
  end

  def filter_records
    MoneyRecord.filter(current_user, @start_date, @end_date, @category)
  end

  expose :active_categories do
    current_user.categories.active.order(created_at: 'DESC')
  end

  expose :archived_categories do
    current_user.categories.archived.order(created_at: 'DESC')
  end

  def index
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
    money_record.adjusted_date = Date.today
    money_record.save

    category = Category.find(params[:money_record][:category_id])
    category.adjust_amount(params[:money_record][:amount].to_d)

    if current_user.use_paycheck?
      paycheck = current_user.paychecks.last
      paycheck.adjust_amount_left(money_record.amount)
    end

    render partial: 'categories/category_table', locals: {records_by_date: get_records_by_date}
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
      :category_id,
      :description
    )
  end
end
