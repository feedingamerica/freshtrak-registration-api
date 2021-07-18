# frozen_string_literal: true

describe Api::PhonesController, type: :controller do
  context 'with authenticated requests' do
    let(:token) { ENV['TOKEN'] }
    let!(:user) { create(:user) }
    let(:person) { create(:person, user: user) }
    let(:phone_contact) do
      create(:contact, contact_type: 'phone', person: person)
    end
    let!(:phone) { create(:phone, contact: phone_contact) }

    before do
      create(:identity, user: user)
      cognito_sign_in(token)
    end

    context 'with -> POST create' do
      it 'creates phone of a user' do
        expect(Phone.all.count).to eq 1
        post '/api/phones', params: { phone: { phone: '2034916633' } }
        expect(Phone.all.count).to eq 2
      end

      it 'does not create an phones with invalid params' do
        # duplicate phone number passed in params
        post '/api/phones', params: { phone: { phone: '2034916636' } }

        expect(response.status).to eq 422
        response_body = JSON.parse(response.body)
        response = response_body['errors']

        expect(response).to eq(
          { 'phone' => ['has already been taken'] }
        )
      end
    end

    context 'with -> GET index' do
      it 'lists phones of users' do
        get '/api/phones'

        expect(response.status).to eq 200
        response_body = JSON.parse(response.body)
        phone_response = response_body['phones'].first
        expect(phone_response).to eq(JSON.parse(phone.to_json))
      end

      it 'responds with empty json if phones not found' do
        Phone.destroy(phone.id)
        get '/api/phones'

        expect(response.body).to eq '{}'
      end
    end

    context 'with -> GET show' do
      it 'renders phones#show template' do
        get "/api/phones/#{phone.id}", params: { id: phone.id }

        expect(response.status).to eq 200
        response_body = JSON.parse(response.body)
        phone_response = response_body['phone']
        expect(phone_response).to eq(JSON.parse(phone.to_json))
      end

      it 'responds with "record_not_found" if phone does not exist' do
        get "/api/phones/#{phone.id + 1}", params: { id: phone.id + 1 }

        expect(response.status).to eq 404
        response_body = JSON.parse(response.body)
        expect(response_body['error']).to eq 'record_not_found'
        expect(response_body['message']).to eq(
          "Couldn't find Phone with 'id'=8"
        )
      end
    end

    context 'with -> PUT update' do
      it 'updates an existing phone' do
        put "/api/phones/#{phone.id}", params: {
          id: phone.id, phone: { phone: '2034916143' }
        }

        expect(response.status).to eq 200
        response_body = JSON.parse(response.body)
        phone_response = response_body['phone']
        expect(phone_response['phone']).to eq '2034916143'
        expect(phone_response).not_to eq(JSON.parse(phone.to_json))
      end

      it 'responds with "record_not_found" if phone_id nil' do
        put "/api/phones/#{phone.id + 1}", params: { id: phone.id + 1 }

        response_body = JSON.parse(response.body)
        expect(response.status).to eq 404
        expect(response_body['error']).to eq 'record_not_found'
        expect(response_body['message']).to eq(
          "Couldn't find Phone with 'id'=10"
        )
      end
    end

    context 'with -> DELETE action' do
      it 'delete phone using id ' do
        delete "/api/phones/#{phone.id}", body: { id: 1 }
        response_body = JSON.parse(response.body)
        expect(response_body['deleted']).to eq(true)
      end

      it 'responds with "record_not_found" if phone does not exist' do
        delete "/api/phones/#{phone.id + 1}", params: {
          id: phone.id + 1
        }

        response_body = JSON.parse(response.body)
        expect(response.status).to eq 404
        expect(response_body['error']).to eq 'record_not_found'
        expect(response_body['message']).to eq(
          "Couldn't find Phone with 'id'=12"
        )
      end
    end
  end
end
