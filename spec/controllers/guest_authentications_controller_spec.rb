# frozen_string_literal: true

describe GuestAuthenticationsController, type: :controller do
  let(:user) { User.create(user_type: :guest) }

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
