# frozen_string_literal: true

describe GuestAuthenticationsController, type: :controller do
  it 'returns a token on post' do
    post '/guest_authentications'

    expect(response.status).to eq(201)
    expect(JSON.parse(response.body)['token']).not_to be_blank
  end

  it 'returns no token on posts' do
    allow_any_instance_of(User).to receive(:save) { false }
    post '/guest_authentications'
    expect(response.status).to eq(422)
  end

  it 'creates a guest user on post' do
    expect { post '/guest_authentications' }
      .to change(User, :count).by(1)
  end
end
