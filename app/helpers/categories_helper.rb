module CategoriesHelper
  def is_negative?(amount)
    amount < 0 ? true : false
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
