module SelectHelper
  def component_select(select_option, opts)
    page.execute_script(<<-JS)
      (function() {
        var label = _.find($('label'), function(el) {
          return el.innerText.trim() === '#{opts[:from]}'
        });
        var component = $(label).next().next();
        var searchField = component.find('.Select-input input').get()[0];
        React.addons.TestUtils.Simulate.focus(searchField);
        React.addons.TestUtils.Simulate.mouseDown(searchField);
        var option = _.find(component.find('.Select-option'), function(o) {
          return o.innerText.trim() === '#{select_option}';
        });
        React.addons.TestUtils.Simulate.mouseDown(option);
        console.log(component.find('.Select-placeholder').text());
      })();
    JS
    label = find('label', text: opts[:from])
    selected = label.parent.find('.Select-placeholder').text
    expect(selected).to eq(select_option)
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
    search = chosen.find('.chosen-search input, .search-field input')
    search.set(input)
  end

  private

  def chosen_id(label)
    id = find_field(label, visible: false)[:id]
    "##{id}_chosen"
  end
end
