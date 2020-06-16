# frozen_string_literal: true

describe CommunicationPreference, type: :model do
  it 'validates member id presence' do
    model = described_class.create(communication_preference_type_id: 1)

    model.member_id = 2
    expect(model).to be_valid

    model.member_id = nil
    expect(model).not_to be_valid
  end

  it 'validates communication preference type id presence' do
    model = described_class.create(member_id: 1)

    model.communication_preference_type_id = 2
    expect(model).to be_valid

    model.communication_preference_type_id = nil
    expect(model).not_to be_valid
  end
end
