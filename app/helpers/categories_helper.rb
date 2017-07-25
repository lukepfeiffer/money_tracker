module CategoriesHelper
  def is_negative?(amount)
    amount < 0 ? true : false
  end

  def paycheck_amount_left
    current_user.paychecks.last.amount_left
  end

  def last_paycheck_amount
    if current_user.paychecks.present?
      added_class = is_negative?(paycheck_amount_left) ? "record red-record" : "record blue-record"
      content_tag(
        :span,
        content_tag(
          :span,
          number_to_currency(paycheck_amount_left),
          class: added_class
        ),
        class: "paycheck_amount_left"
      )
    else
      "No records found"
    end
  end

  def render_archive_link(category)
    if category.archived_at == nil
    "<button class='danger small'> Archive </button>"
    end
  end

  def amount_label(form, use_paycheck)
    if use_paycheck
      form.label :paycheck_percentage
    else
      form.label :amount
    end
  end

  def amount_field(form, use_paycheck)
    if use_paycheck
      form.number_field :paycheck_percentage, class: 'number-field', step: '0.01', placeholder: '25.00'
    else
      form.number_field :amount, class: 'number-field', step: '0.01', placeholder: '60.00'
    end
  end
end
