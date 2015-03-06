RSpec.feature 'View helper' do
  scenario 'is used to add a component to the view' do
    visit '/'

    expect(find(:css, 'h2').text).to eq('Sub-heading component')
  end
end
