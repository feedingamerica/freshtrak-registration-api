# frozen_string_literal: true

describe Api::ReservationsController, type: :controller do
  before do
    allow_any_instance_of(User).to receive(:sync_to_pantry_trak)
    allow_any_instance_of(Reservation).to receive(:sync_to_pantry_trak)
    sign_in_api(user)
    allow(PantryFinderApi).to receive(:new).and_return(pantry_finder_api)
  end

  let(:user) { User.create(user_type: :guest) }
  let(:pantry_finder_api) { instance_double(PantryFinderApi) }
  # create another reservation to ensure that api is scoped to user
  let(:other_user) { User.create(user_type: :guest) }
  let!(:other_reservation) { other_user.reservations.create!(event_date_id: 1) }

  it 'indexes all reservations belonging to a user' do
    reservations = 2.times.map { user.reservations.create!(event_date_id: 1) }

    get '/api/reservations'

    expect(response.status).to eq(200)
    response_body = JSON.parse(response.body)
    expect(response_body.pluck('id').sort).to eq(reservations.pluck(:id).sort)
  end

  it 'shows a reservation' do
    reservation = user.reservations.create!(event_date_id: 1)

    get "/api/reservations/#{reservation.id}"

    expect(response.status).to eq(200)
    response_body = JSON.parse(response.body)
    expect(response_body['id']).to eq(reservation.id)
    expect(response_body['event_date_id']).to eq(reservation.event_date_id)
  end

  it 'does not show a reservation belonging to another user' do
    get "/api/reservations/#{other_reservation.id}"

    expect(response.status).to eq(404)
  end

  it 'creates a reservation' do
    event_date_id = (user.reservations.pluck(:event_date_id).max || 0) + 1
    allow(pantry_finder_api).to receive(:event_date)
      .with(event_date_id.to_s).and_return(capacity: Float::INFINITY)

    expect do
      post '/api/reservations', reservation: { event_date_id: event_date_id }
    end.to change(Reservation, :count).by(1)

    expect(response.status).to eq(201)
    response_body = JSON.parse(response.body)
    expect(response_body['user_id']).to eq(user.id)
    expect(response_body['event_date_id']).to eq(event_date_id)
  end

  it 'does not create a reservation if the event date does not exist' do
    allow(pantry_finder_api).to receive(:event_date)
      .and_raise(Faraday::ResourceNotFound.new('event not found'))

    expect do
      post '/api/reservations', reservation: { event_date_id: 9999 }
    end.to change(Reservation, :count).by(0)

    expect(response.status).to eq(422)
    response_body = JSON.parse(response.body)
    expect(response_body['pantry_finder_api']).to include('event not found')
  end

  it 'deletes a reservation' do
    reservation = user.reservations.create!(event_date_id: 1)

    expect { delete "/api/reservations/#{reservation.id}" }
      .to change(Reservation, :count).by(-1)

    expect(response.status).to eq(200)
  end

  it 'does not delete a reservation belonging to another user' do
    expect { delete "/api/reservations/#{other_reservation.id}" }
      .not_to change(Reservation, :count)

    expect(response.status).to eq(403)
  end
end
