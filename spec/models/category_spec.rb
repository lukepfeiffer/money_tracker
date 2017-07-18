require 'rails_helper'

describe Category do
  context '#active' do
    let(:archived) {Fabricate(:archived_category)}
    let(:active) {Fabricate(:category)}

    it 'returns active categories' do
      actual = Category.all.active
      expect(actual).to include(active)
      expect(actual).to_not include(archived)
    end

    it 'returns archived categories' do
      actual = Category.all.archived
      expect(actual).to include(archived)
      expect(actual).to_not include(active)
    end
  end
end
