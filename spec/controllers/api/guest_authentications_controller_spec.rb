# frozen_string_literal: true

describe Api::GuestAuthenticationsController, type: :controller do
  it 'returns a token on post' do
    post '/api/guest_authentications'

    expect(response.status).to eq(201)
    expect(JSON.parse(response.body)['token']).not_to be_blank
  end

  it 'creates a guest user on post' do
    expect { post '/api/guest_authentications' }
      .to change(User, :count).by(1)
  end
end
