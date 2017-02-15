# frozen_string_literal: true
require 'English'

RSpec.feature 'Component generator', :js do
  load 'lib/generators/generate_component.thor'

  let(:test_component_path) do
    UiComponents::Engine.root.join('app', 'cells', 'test_component')
  end

  before do
    expect(Dir.exist?(test_component_path)).to be(false)
    GenerateComponent.start(%w(test_component))
    expect(Dir.exist?(test_component_path)).to be(true)
    require test_component_path.join('test_component_cell')
  end

  after do
    FileUtils.rm_r(test_component_path)
  end

  scenario 'generates a new component' do
    visit '/'

    click_on 'UI Components'

    expect(page).to have_content('Test Component')
    expect(page).to have_content("I didn't change the default description.")
  end
end
