require 'English'

RSpec.feature 'Component generator', :js do
  let(:test_component_path) do
    UiComponents::Engine.root.join('app', 'cells', 'test_component')
  end

  before do
    expect(Dir.exist?(test_component_path)).to be(false)

    output = `bundle exec thor generate_component test_component 2>&1`
    fail output unless $CHILD_STATUS.success?

    expect(Dir.exist?(test_component_path)).to be(true)
    require test_component_path.join('test_component_cell')
  end

  after do
    FileUtils.rm_r(test_component_path)
  end

  scenario 'generates a new component' do
    visit '/'

    expect(page).to have_content('TestComponentCell')
    expect(page).to have_content("I didn't change the default description.")
  end
end
