module MoneyRecordsHelper
  def is_negative_amount?(money_record)
    if money_record.amount < 0
      true
    else
      false
    end
  end
end
