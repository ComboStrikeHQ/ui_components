# frozen_string_literal: true
RSpec.describe Styleguide do
  describe '.components' do
    it 'returns a list of cells' do
      expect(described_class.components).to include(MarkdownReadonlyCell)
    end
  end
end
