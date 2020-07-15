# frozen_string_literal: true

describe CarrierType, type: :model do
  it 'validates name presence' do
    model = described_class.create(email: '123@fgdsd.com')

    model.name = 'test'
    expect(model).to be_valid

    model.name = nil
    expect(model).not_to be_valid

    model.name = ''
    expect(model).not_to be_valid
  end

  it 'validates email presence' do
    model = described_class.create(name: '123')

    model.email = 'test@test.com'
    expect(model).to be_valid

    model.email = nil
    expect(model).not_to be_valid

    model.email = ''
    expect(model).not_to be_valid
  end
end
