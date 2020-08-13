# frozen_string_literal: true

describe User, type: :model do
  before do
    allow(PantryTrak::Client).to receive(:new).and_return(pantry_track_client)
    allow(pantry_track_client).to receive(:create_user)
    allow(described_class).to receive(:sync_to_pantry_trak)
  end

  let(:user) { described_class.create(user_type: :guest) }
  let(:pantry_track_client) { instance_double(PantryTrak::Client) }

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

    user.phone = '16145551234'
    expect(user).not_to be_valid

    user.phone = '614555123X'
    expect(user).not_to be_valid

    user.phone = '6145551234'
    expect(user).to be_valid
  end

  it 'strips non-digit chars from phone' do
    user.phone = '614-555-1234'
    expect(user).to be_valid
  end
end
