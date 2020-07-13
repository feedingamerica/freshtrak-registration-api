# frozen_string_literal: true

describe PhoneNumber, type: :model do
  it 'validates location type id presence' do
    model = described_class.create(
      phone_number: '1231231234',
      carrier_type_id: 1
    )

    model.location_type_id = 1
    expect(model).to be_valid

    model.location_type_id = nil
    expect(model).not_to be_valid
  end

  it 'validates carrier type id presence' do
    model = described_class.create(
      phone_number: '1231231234',
      location_type_id: 1
    )

    model.carrier_type_id = 1
    expect(model).to be_valid

    model.carrier_type_id = nil
    expect(model).not_to be_valid
  end

  it 'validates phone number presence' do
    model = described_class.create(
      carrier_type_id: 1,
      location_type_id: 1
    )

    model.phone_number = '1231231234'
    expect(model).to be_valid

    model.phone_number = nil
    expect(model).not_to be_valid

    model.phone_number = ''
    expect(model).not_to be_valid
  end

  it 'validates phone number format' do
    model = described_class.create(
      carrier_type_id: 1,
      location_type_id: 1
    )

    model.phone_number = '1231231234'
    expect(model).to be_valid

    model.phone_number = '4444444'
    expect(model).not_to be_valid

    model.phone_number = '16145551234'
    expect(model).not_to be_valid

    model.phone_number = '614555123X'
    expect(model).not_to be_valid
  end
end
