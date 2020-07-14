# frozen_string_literal: true

describe UserDetail, type: :model do
  it 'validates name presence' do
    model = described_class.create(user_id: 1)

    model.name = 'test'
    expect(model).to be_valid

    model.name = nil
    expect(model).not_to be_valid

    model.name = ''
    expect(model).not_to be_valid
  end

  it 'validates user id presence' do
    model = described_class.create(name: 'test')

    model.user_id = 1
    expect(model).to be_valid

    model.user_id = nil
    expect(model).not_to be_valid
  end
end
