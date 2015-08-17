RSpec.describe UiComponents::Cell do
  it 'accepts properties' do
    component = TestCell.new(something: 'foo', something_else: 'bar')
    expect(component.something).to eq('foo')
    expect(component.something_else).to eq('bar')
  end

  it 'complains if a mandatory property is not set' do
    expect do
      TestCell.new
    end.to raise_error(UiComponents::Cell::MandatoryPropertyNotSet,
                       'Following mandatory arguments have not been provided: something')
  end
end

class TestCell < UiComponents::Cell
  property :something, true, 'Something...'
  property :something_else, false, 'Something else entirely...'
end
