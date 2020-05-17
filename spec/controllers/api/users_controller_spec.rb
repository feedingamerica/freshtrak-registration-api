# frozen_string_literal: true

describe Api::UsersController, type: :controller do
  context 'with authenticated requests' do
    let(:user) { User.create(user_type: :guest) }

    before do
      sign_in_api(user)
    end

    it 'shows the logged in user' do
      get '/api/user'

      expect(response.status).to eq(200)
      expect(JSON.parse(response.body)).to eq(user.as_json)
    end

    it 'updates the logged in user' do
      params = { first_name: 'John', middle_name: 'Jim', last_name: 'Smith',
                 suffix: 'Jr', date_of_birth: '01/01/1980', gender: 'Male',
                 phone: '6145551234', permission_to_text: true, email: 'j@s.co',
                 permission_to_email: false, address_line_1: '123 Main St',
                 address_line_2: '#6', city: 'Columbus', state: 'Oh',
                 zip_code: '43201', license_plate: 'ABC123',
                 seniors_in_household: 1, adults_in_household: 2,
                 children_in_household: 3 }
      put '/api/user', user: params

      expect(response.status).to eq(200)
      user.reload
      params.each do |key, value|
        updated_value = user.send(key)
        expected_value = if updated_value.class.respond_to?(:parse)
                           updated_value.class.parse(value)
                         else
                           value
                         end

        expect(updated_value).to eq(expected_value)
      end
    end

    it 'responds with unprocessible_entity if the update fails' do
      put '/api/user', user: { phone: 'oops' }

      expect(response.status).to eq(422)
    end
  end

  context 'without authenticated requests' do
    it 'responds with unauthorized' do
      get '/api/user'
      expect(response.status).to eq(401)

      put '/api/user', user: { first_name: 'John' }
      expect(response.status).to eq(401)
    end
  end
end
