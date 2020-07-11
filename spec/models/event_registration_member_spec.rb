# frozen_string_literal: true

describe EventRegistrationMember, type: :model do
  it 'validates event registration id presence' do
    model = described_class.create(household_member_id: 1)
    model.event_registration_id = 1
    expect(model).to be_valid

    model.event_registration_id = nil
    expect(model).not_to be_valid
  end

  it 'validates member id presence' do
    model = described_class.create(event_registration_id: 1)

    model.household_member_id = 1
    expect(model).to be_valid

    model.household_member_id = nil
    expect(model).not_to be_valid
  end
end
