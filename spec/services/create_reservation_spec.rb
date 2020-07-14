# frozen_string_literal: true

describe CreateReservation do
  let(:user) { User.create(user_type: :guest) }
  let(:event_date_id) { unique_event_date_id }
  let(:event_slot_id) { unique_event_slot_id }

  let(:pantry_finder_api) { instance_double(PantryFinderApi) }
  let(:capacity) { 100 }
  let(:slot_capacity) { 100 }

  let(:service) do
    described_class.new(
      user_id: user.id, event_date_id: event_date_id,
      event_slot_id: event_slot_id
    )
  end
  let(:service_call) { service.call }

  before do
    allow(PantryFinderApi).to receive(:new).and_return(pantry_finder_api)
    allow(pantry_finder_api).to receive(:event_date)
      .and_return(event_date_response)
  end

  it 'creates a reservation' do
    expect { service_call }.to change(Reservation, :count).by(1)
    reservation = service_call.reservation

    expect(service_call).to be_success
    expect(reservation).to be_persisted
    expect(reservation.user_id).to eq(user.id)
    expect(reservation.event_date_id).to eq(event_date_id)
  end

  context 'when user already has a reservation for this event' do
    before do
      user.reservations.create!(
        event_date_id: event_date_id, event_slot_id: event_slot_id
      )
    end

    it 'does not create a reservation' do
      expect { service_call }.not_to change(Reservation, :count)

      expect(service_call).not_to be_success
      expect(service_call.errors.full_messages).to eq(
        ['User has already registered for this event']
      )
    end
  end

  context 'when event date is at capacity' do
    let(:capacity) { 0 }

    it 'does not create a reservation' do
      expect { service_call }.not_to change(Reservation, :count)

      expect(service_call).not_to be_success
      expect(service_call.errors.full_messages).to eq(
        ['Event date is at capacity']
      )
    end
  end

  context 'when event slot is at capacity' do
    let(:slot_capacity) { 0 }

    it 'does not create a reservation' do
      expect { service_call }.not_to change(Reservation, :count)

      expect(service_call).not_to be_success
      expect(service_call.errors.full_messages).to eq(
        ['Event slot is at capacity']
      )
    end
  end

  context 'when reservation fails to save' do
    before do
      allow(service.reservation).to receive(:save).and_return(false)
    end

    it 'is not successful' do
      expect { service_call }.not_to change(Reservation, :count)

      expect(service_call).not_to be_success
    end
  end

  context 'when a faraday error occurs' do
    before do
      allow(pantry_finder_api).to receive(:event_date)
        .with(event_date_id).and_raise(Faraday::Error.new('fail'))
    end

    it 'does not create a reservation' do
      expect { service_call }.not_to change(Reservation, :count)

      expect(service_call).not_to be_success
      expect(service_call.errors.full_messages).to eq(
        ['Pantry finder api fail']
      )
    end
  end

  def unique_event_date_id
    (Reservation.pluck(:event_date_id).max || 0) + 1
  end

  def unique_event_slot_id
    (Reservation.pluck(:event_slot_id).compact.max || 0) + 1
  end

  def event_date_response
    {
      id: event_date_id, event_id: 663, capacity: capacity, accept_walkin: 1,
      accept_reservations: 1, accept_interest: 1, start_time: '12 PM',
      end_time: '3 PM', date: '2020-07-30',
      event_hours:
      [
        {
          event_hour_id: 7048, capacity: capacity, start_time: '12 PM',
          end_time: '12:59 PM', open_slots: 33, event_slots:
          [
            {
              event_slot_id: event_slot_id, capacity: slot_capacity,
              start_time: '12 PM', end_time: '12:59 PM', open_slots: 33
            }
          ]
        }
      ]
    }
  end
end
