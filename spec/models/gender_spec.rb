# frozen_string_literal: true

describe Gender, type: :model do
  it 'validates name presence' do
    model = described_class.create

    model.name = 'test'
    expect(model).to be_valid

    model.name = nil
    expect(model).not_to be_valid

    model.name = ''
    expect(model).not_to be_valid
  end
end
