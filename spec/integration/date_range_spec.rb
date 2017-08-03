# frozen_string_literal: true

RSpec.feature 'Date Range', :js do
  def chooser(text = nil)
    find('.ui-components-date-range', text: text)
  end

  def select_range(text)
    find('.ranges li', text: text).click
  end

  def date(type)
    find("#date_range_my_form_my_date_range_#{type}", visible: false).value
  end

  def datepicker(type)
    find("[name=daterangepicker_#{type}]", visible: false).value
  end

  scenario 'can select different ranges' do
    visit '/date_range'

    expect(datepicker(:start)).to eq(Date.yesterday.to_s)
    expect(datepicker(:end)).to eq(Date.yesterday.to_s)

    chooser("Yesterday (#{Date.yesterday} - #{Date.yesterday})").click

    select_range('Today')
    expect(date(:from)).to eq(Time.zone.today.to_s)
    expect(date(:to)).to eq(Time.zone.today.to_s)

    chooser.click
    select_range('Last 7 Days')
    expect(date(:from)).to eq((Time.zone.today - 7.days).to_s)
    expect(date(:to)).to eq(Date.yesterday.to_s)

    expect(datepicker(:start)).to eq((Time.zone.today - 7.days).to_s)
    expect(datepicker(:end)).to eq(Date.yesterday.to_s)

    chooser.click
    select_range 'Last 14 Days'
    expect(date(:from)).to eq((Time.zone.today - 14.days).to_s)
    expect(date(:to)).to eq(Date.yesterday.to_s)

    expect(datepicker(:start)).to eq((Time.zone.today - 14.days).to_s)
    expect(datepicker(:end)).to eq(Date.yesterday.to_s)

    chooser.click
    select_range 'Month to Date'
    expect(date(:from)).to eq(Time.zone.today.beginning_of_month.to_s)
    expect(date(:to)).to eq(Time.zone.today.to_s)

    expect(datepicker(:start)).to eq(Time.zone.today.beginning_of_month.to_s)
    expect(datepicker(:end)).to eq(Time.zone.today.to_s)

    chooser.click
    select_range 'Last Month'
    expect(date(:from)).to eq((Time.zone.today - 1.month).beginning_of_month.to_s)
    expect(date(:to)).to eq((Time.zone.today - 1.month).end_of_month.to_s)

    expect(datepicker(:start)).to eq((Time.zone.today - 1.month).beginning_of_month.to_s)
    expect(datepicker(:end)).to eq((Time.zone.today - 1.month).end_of_month.to_s)
  end

  scenario 'ranges are configurable' do
    visit '/date_range_custom_ranges'

    field = find('.ui-components-date-range')

    field.click

    expect(page).to have_content('Next 10 days')

    link = find('li:first-child')
    expect(link.text).to eq('Next 10 days')
    link.click

    expect(field.text).to eq('Next 10 days (2015-06-22 - 2015-07-01)')
  end

  scenario 'start/end dates are configurable' do
    visit '/date_range_start_end_date'
    field = find('.ui-components-date-range')

    expect(field.text).to eq('Custom Range (2016-01-01 - 2016-01-21)')
    expect(date(:from)).to eq('2016-01-01')
    expect(date(:to)).to eq('2016-01-21')
  end

  scenario 'min/max dates are configurable' do
    visit '/date_range_min_max_date'
    find('.ui-components-date-range').click
    find('li', text: 'Custom Range').click

    within('.calendar.second') do
      find_all('td.available', count: 21)
      expect(all('td.available').map { |td| td.text.to_i }).to eq((3..23).to_a)
    end
  end

  scenario 'submits enclosing form on value change' do
    visit '/date_range_submit_on_change'
    find('.ui-components-date-range').click
    find('li', text: 'Custom Range').click
    within('.calendar.second') do
      find('td:not(.off)', text: '21').click
    end
    within('.calendar.first') do
      find('td:not(.off)', text: '22').click
    end
    click_on 'Apply'

    params = JSON.parse(find('pre').text)['my_form']
    expect(Date.parse(params['my_date_range_from']).day).to eq(21)
    expect(Date.parse(params['my_date_range_to']).day).to eq(22)
  end
end
