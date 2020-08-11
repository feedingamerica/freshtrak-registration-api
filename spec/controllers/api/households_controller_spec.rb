# frozen_string_literal: true

describe Api::HouseholdsController, type: :controller do
  context 'with authenticated requests' do
    let(:user) { User.create(user_type: :guest) }
    let(:pantry_track_client) { instance_double(PantryTrak::Client) }

    let(:household) do
      Household.create(number: 2, name: 'Fun House',
                       added_by: user.id, last_updated_by: user.id,
                       household_address_attributes: {
                         line_1: '123 Test St',
                         line_2: nil,
                         city: 'Irontown',
                         state: 'OH',
                         zip_code: '43214',
                         zip_4: nil,
                         added_by: user.id,
                         last_updated_by: user.id
                       })
    end

    before do
      allow(PantryTrak::Client).to receive(:new).and_return(pantry_track_client)
      allow(pantry_track_client).to receive(:create_user)
      allow(User).to receive(:sync_to_pantry_trak)
      sign_in_api(user)
    end

    it 'adds a household' do
      expect do
        post '/api/households', household: { number: 2, name: 'Fun House',
                                             household_address_attributes: {
                                               line_1: '123 Test St',
                                               line_2: nil,
                                               city: 'Irontown',
                                               state: 'OH',
                                               zip_code: '43214',
                                               zip_4: nil
                                             } }
      end.to change(Household, :count).by(1)
    end

    it 'responds with "unprocessable entity" if bad create payload' do
      post '/api/households', household: { number: 2, name: 'Fun House' }
      expect(response.status).to eq(422)
    end

    it 'gets a household' do
      get "/api/households/#{household.id}"

      expect(response.status).to eq(200)
      response_body = JSON.parse(response.body)
      expect(response_body['id']).to eq(household.id)
    end

    it 'responds with "not found" if household does not exist' do
      get "/api/households/#{household.id + 1}"

      expect(response.status).to eq(404)
    end

    it 'updates the household attributes' do
      updated_name = 'Unfun House'
      updated_number = 3

      household.name = updated_name
      household.number = updated_number

      put "/api/households/#{household.id}", household: {
        name: updated_name,
        number: updated_number
      }

      expect(response.status).to eq(200)
      response_body = JSON.parse(response.body)
      expect(response_body['name']).to eq(updated_name)
      expect(response_body['number']).to eq(updated_number)
    end

    it 'responds with "unprocessable entity" if bad update payload' do
      put "/api/households/#{household.id}", household: {
        name: nil
      }
      expect(response.status).to eq(422)
    end

    it 'responds with "unprocessable entity" if household is deleted' do
      allow(Household).to receive(:find_by).and_return(household)
      allow(household).to receive(:destroy).and_return(false)
      delete "/api/households/#{household.id}"
      expect(response.status).to eq(422)
    end

    it 'deletes a household' do
      delete "/api/households/#{household.id}"
      expect(response.status).to eq(200)
      response_body = JSON.parse(response.body)
      expect(response_body['deleted']).to eq(true)
    end
  end

  context 'without authenticated requests' do
    it 'responds with unauthorized' do
      post '/api/households', household: { name: 'Haunted House' }
      expect(response.status).to eq(401)
    end
  end
end
