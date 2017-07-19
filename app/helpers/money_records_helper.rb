module MoneyRecordsHelper
  def is_negative_amount?(money_record)
    if money_record.present?
      money_record.amount < 0 ? true : false
    end
  end
end
