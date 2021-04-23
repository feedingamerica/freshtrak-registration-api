# frozen_string_literal: true

describe Household, type: :model do
  let(:household) { create(:agency) }

#   it 'has many members' do
#     household_members = 5.times.map do
#       create(:household_member, houdhold: household)
#     end
#     expect(household.household_members.pluck(:id))
#       .to eq(household_members.pluck(:id))
#   end

#   it 'has one address' do
#     expect(household.household_address).to be_an_instance_of(HouseholdAddress)
#   end

#   it 'has many event registrations' do
#     household_event_registrations = 5.times.map do
#       create(:household_event_registration, household: household)
#     end
#     expect(household.household_event_registrations.pluck(:id))
#       .to eq(household_event_registrations.pluck(:id))
#   end
end
