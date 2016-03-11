# frozen_string_literal: true
RSpec.feature 'Checkbox list', :js do
  scenario 'values are rendered as a list of checkboxes' do
    visit '/checkbox_list'

    check 'Apple'
    check 'Orange'

    expect(all('input').map(&:checked?)).to eq([true, true, false])
    expect(all('input').map { |i| i[:name] }).to eq(['fox[list][]'] * 3)
    expect(all('input').map { |i| i[:value] }).to eq(%w(apple banana kiwi))
  end
end
