# frozen_string_literal: true

describe User, type: :model do
  let(:user) { described_class.create(user_type: :guest) }

  it 'sets an unique identification code' do
    expect(user.identification_code).not_to be_blank

    new_user = described_class.new(user_type: :guest)
    new_user.identification_code = user.identification_code

    expect(new_user.save).to be_truthy
    expect(new_user.identification_code).not_to eq(user.identification_code)
  end

  it 'validates phone' do
    user.phone = '614555'
    expect(user).not_to be_valid

    user.phone = '614-555-1234'
    expect(user).not_to be_valid

    user.phone = '16145551234'
    expect(user).not_to be_valid

    user.phone = '614555123X'
    expect(user).not_to be_valid

    user.phone = '6145551234'
    expect(user).to be_valid
  end
end
