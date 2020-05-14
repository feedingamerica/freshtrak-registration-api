# frozen_string_literal: true

describe Api::GuestAuthenticationsController, type: :controller do
  it 'should return a token on post' do
    post '/api/guest_authentications'

    expect(response.status).to eq(201)
    expect(JSON.parse(response.body)['token']).to_not be_blank
  end

  it 'should create a guest user on post' do
    expect { post '/api/guest_authentications' }
      .to change { User.count }.by(1)
  end
end
