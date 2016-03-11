# frozen_string_literal: true
RSpec.feature 'Markdown Textarea', :js do
  def preview_html
    find(:css, '.tab-pane.active').base.inner_html.strip
  end

  it 'has an edit and preview tab for markdown text' do
    visit '/markdown_textarea'

    click_link 'Preview'
    expect(preview_html).to eq('<p>test</p>')

    click_link 'Edit'
    fill_in 'hello', with: 'I like _apples_.'

    click_link 'Preview'
    expect(preview_html).to eq('<p>I like <em>apples</em>.</p>')

    click_link 'Edit'
    textarea = find(:css, '.tab-pane.active textarea')
    expect(textarea.value).to eq('I like _apples_.')
  end

  it 'can get its value from a model' do
    visit '/markdown_textarea?use_model=1'

    textarea = find(:css, '.tab-pane.active textarea')
    expect(textarea.value).to eq('test_from_model')
  end
end
