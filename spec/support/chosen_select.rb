module ChosenSelect
  def chosen_select(item_text, options)
    field = find_field(options[:from], visible: false)
    find("##{field[:id]}_chosen") # Throws an exception if the chosen is missing.
    id = field[:id]
    select item_text, options.merge(visible: false)
    page.execute_script("$('##{id}').trigger('chosen:updated')")
  end

  def chosen_choices(label)
    id = chosen_id(label)
    all(:css, "#{id} .chosen-choices li").map(&:text).select(&:present?)
  end

  def chosen_options(label)
    id = chosen_id(label)
    find(:css, id).click
    chosen_choices(label) +
      all(:css, "#{id} .chosen-results li").map(&:text).select(&:present?)
  end

  def chosen_search(label, input)
    field = find_field(label, visible: false)
    chosen = find("##{field[:id]}_chosen")
    chosen.click
    search = chosen.find('.chosen-search input')
    search.set(input)
  end

  private

  def chosen_id(label)
    id = find_field(label, visible: false)[:id]
    "##{id}_chosen"
  end
end
