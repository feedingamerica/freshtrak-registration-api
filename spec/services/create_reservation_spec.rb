# frozen_string_literal: true

describe CreateReservation do
  before do
    allow(PantryTrak::Client).to receive(:new).and_return(pantry_track_client)
    allow(pantry_track_client).to receive(:create_reservation)
    allow(Reservation).to receive(:sync_to_pantry_trak)

    allow(pantry_track_client).to receive(:create_user)
    allow(User).to receive(:sync_to_pantry_trak)

    allow(PantryFinderApi).to receive(:new).and_return(pantry_finder_api)
    allow(pantry_finder_api).to receive(:event_date)
      .with(event_date_id).and_return(capacity: capacity)
  end

  let(:user) { User.create(user_type: :guest) }
  let(:event_date_id) { unique_event_date_id }

  let(:pantry_finder_api) { instance_double(PantryFinderApi) }

  let(:pantry_track_client) { instance_double(PantryTrak::Client) }
  let(:capacity) { 100 }

  let(:service) do
    described_class.new(user_id: user.id, event_date_id: event_date_id)
  end
  let(:service_call) { service.call }

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
      user.reservations.create!(event_date_id: event_date_id)
    end

    it 'does not create a reservation' do
      expect { service_call }.not_to change(Reservation, :count)

      expect(service_call).not_to be_success
      expect(service_call.errors.full_messages).to eq(
        ['User has already registered for this event']
      )
    end
  end

  context 'when event is at capacity' do
    let(:capacity) { 0 }

    it 'does not create a reservation' do
      expect { service_call }.not_to change(Reservation, :count)

      expect(service_call).not_to be_success
      expect(service_call.errors.full_messages).to eq(
        ['Event date is at capacity']
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
end
