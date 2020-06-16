# frozen_string_literal: true

describe AltIdType, type: :model do
  it 'validates name presence' do
    model = described_class.create

    model.name = 'License Plate Number'
    expect(model).to be_valid

    model.name = nil
    expect(model).not_to be_valid

    model.name = ''
    expect(model).not_to be_valid
  end

  it 'validates description length' do
    model = described_class.create
    model.name = '123'

    model.description = nil
    expect(model).to be_valid

    model.description = '1' * 99
    expect(model).to be_valid

    model.description = '1' * 100
    expect(model).to be_valid

    model.description = '1' * 101
    expect(model).not_to be_valid
  end
end
