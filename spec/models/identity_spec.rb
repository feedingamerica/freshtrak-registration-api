# frozen_string_literal: true

describe Identity, type: :model do
  let(:identity) { create(:identity) }

  it 'belongs to an user' do
    expect(identity.user).to be_an_instance_of(User)
  end
end
