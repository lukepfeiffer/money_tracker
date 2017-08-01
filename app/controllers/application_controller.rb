class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user
  helper_method :get_records_by_date
  helper_method :filter_records_by_date

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def get_records_by_date(category = nil, archived = false)
    if category.present?
      dates = category.money_records.map(&:adjusted_date).uniq.sort.reverse
      category_ids = category.id
    elsif archived
      dates = current_user.get_money_records_dates(archived)
      category_ids = archived_categories.map(&:id)
    else
      dates = current_user.get_money_records_dates
      category_ids = active_categories.map(&:id)
    end

    dates = dates.uniq.sort.reverse

    dates.each_with_object( [] ) do |date, records|
      records << MoneyRecord.where(adjusted_date: date, category_id: category_ids)
    end
  end

  def filter_records_by_date(records)
    dates = records.map(&:adjusted_date).uniq.sort.reverse

    dates.each_with_object( [] ) do |date, date_records|
      records.each_with_object( [] ) do |record, records|
        records << record if record.adjusted_date == date
      end

      date_records << records
    end
  end

end
