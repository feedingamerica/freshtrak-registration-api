# frozen_string_literal: true

describe Authentication, type: :model do
  before do
    allow(PantryTrak::Client).to receive(:new).and_return(pantry_track_client)
    allow(pantry_track_client).to receive(:create_user)
    allow(User).to receive(:sync_to_pantry_trak)
  end

  let(:authentication) { described_class.create(user_id: user.id) }
  let(:user) { User.create(user_type: :guest) }
  let(:pantry_track_client) { instance_double(PantryTrak::Client) }

  it 'authenticates with token' do
    expect(authentication.token).not_to be_blank

    response = described_class.authenticate_with_token(authentication.token)

    expect(response).to eq(authentication)
  end

  it 'expires' do
    expect(authentication.expires_at).not_to be_blank

    expect(described_class.unexpired.pluck(:id)).to include(authentication.id)

    Timecop.freeze(Time.now + Authentication::EXPIRATION_PERIOD + 1.minute) do
      expect(described_class.unexpired.pluck(:id))
        .not_to include(authentication.id)
    end
  end
end
