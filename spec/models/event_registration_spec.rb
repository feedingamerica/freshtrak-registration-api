# frozen_string_literal: true

describe EventRegistration, type: :model do
  it 'validates household id presence' do
    model = described_class.create(event_status_id: 1, event_slot_id: 2)

    model.household_id = 1
    expect(model).to be_valid

    model.household_id = nil
    expect(model).not_to be_valid
  end

  it 'validates event status id presence' do
    model = described_class.create(household_id: 1, event_slot_id: 2)

    model.event_status_id = 1
    expect(model).to be_valid

    model.event_status_id = nil
    expect(model).not_to be_valid
  end

  it 'validates event slot id presence' do
    model = described_class.create(household_id: 1, event_status_id: 2)

    model.event_slot_id = 1
    expect(model).to be_valid

    model.event_slot_id = nil
    expect(model).not_to be_valid
  end
end
