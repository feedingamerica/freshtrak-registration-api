# frozen_string_literal: true

describe GuestAuthenticationsController, type: :controller do
  let(:user) { User.create(user_type: :guest) }
  let(:pantry_track_client) { instance_double(PantryTrak::Client) }

  before do
    allow(PantryTrak::Client).to receive(:new).and_return(pantry_track_client)
    allow(pantry_track_client).to receive(:create_user)
    allow(User).to receive(:sync_to_pantry_trak)
  end

  it 'returns a token on post' do
    post '/guest_authentications'

    expect(response.status).to eq(201)
    expect(JSON.parse(response.body)['token']).not_to be_blank
  end

  context 'when user is not saved' do
    before do
      allow(User).to receive(:new).and_return(user)
      allow(user).to receive(:save).and_return(false)
    end

    it 'responds with "unprocessable entity"' do
      post '/guest_authentications'
      expect(response.status).to eq(422)
    end
  end

  it 'creates a guest user on post' do
    expect { post '/guest_authentications' }
      .to change(User, :count).by(1)
  end
end
