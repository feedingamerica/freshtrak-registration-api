# frozen_string_literal: true

describe AltId, type: :model do
  it 'validates value presence' do
    model = described_class.create(alt_id_type_id: 1)

    model.value = '1234'
    expect(model).to be_valid

    model.value = nil
    expect(model).not_to be_valid

    model.value = ''
    expect(model).not_to be_valid
  end

  it 'validates value length' do
    model = described_class.create(alt_id_type_id: 1)

    model.value = '1' * 99
    expect(model).to be_valid

    model.value = '1' * 100
    expect(model).to be_valid

    model.value = '1' * 101
    expect(model).not_to be_valid
  end

  it 'validates alt id type presence' do
    model = described_class.create(value: '123')

    model.alt_id_type_id = 123
    expect(model).to be_valid

    model.alt_id_type_id = nil
    expect(model).not_to be_valid

    model.alt_id_type_id = ''
    expect(model).not_to be_valid
  end
end
