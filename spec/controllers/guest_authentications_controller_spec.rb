# frozen_string_literal: true

describe GuestAuthenticationsController, type: :controller do
  before do
    allow_any_instance_of(User).to receive(:sync_to_pantry_trak)
  end
  it 'returns a token on post' do
    post '/guest_authentications'

    expect(response.status).to eq(201)
    expect(JSON.parse(response.body)['token']).not_to be_blank
  end

  it 'creates a guest user on post' do
    expect { post '/guest_authentications' }
      .to change(User, :count).by(1)
  end
end
