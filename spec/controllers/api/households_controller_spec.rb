# frozen_string_literal: true

describe Api::HouseholdsController, type: :controller do
  let(:user) { User.create(user_type: :guest, first_name: 'Cory', last_name: 'Hahn',
                            date_of_birth: DateTime.parse('31/08/1991'),
                            email: 'chahn@test.com') }

  let(:household) { Household.create(number: 2, name: 'Fun House', 
                                            added_by: user.id, last_updated_by: user.id,
                                            address_attributes: {
                                              line_1: '123 Test St',
                                              line_2: nil,
                                              city: 'Irontown',
                                              state: 'OH',
                                              zip_code: '43214',
                                              zip_4: nil,
                                              added_by: user.id,
                                              last_updated_by: user.id 
                                              },
                                            members_attributes: [{
                                              first_name: 'Phillip',
                                              last_name: 'Fry',
                                              date_of_birth: DateTime.parse('31/08/1991'),
                                              is_head_of_household: true,
                                              email: 'pfry@test.com',
                                              user_id: user.id,
                                              added_by: user.id
                                            }])
                                            }

  let(:other_user) { User.create(user_type: :guest) }
  let(:other_household) { other_member.create_household(number: 1, name: 'Unfun House',
                                                      address_attributes: {
                                                        line_1: '321 Limbo St',
                                                        line_2: nil,
                                                        city: 'Slabtown',
                                                        state: 'OH',
                                                        zip_code: '45805',
                                                        zip_4: nil
                                                      },
                                                      members_attributes: [{
                                                        first_name: 'Bender',
                                                        last_name: 'Rodriguez',
                                                        date_of_birth: DateTime.parse('31/08/1991'),
                                                        is_head_of_household: true,
                                                        email: 'brodriguez@test.com'
                                                      }])
                                                    }


  context 'with authenticated requests' do

    before do
      sign_in_api(user)
    end
    
    it 'adds a household' do
      expect do
        post '/api/households', household: {number: 2, name: 'Fun House',
                                            address_attributes: {
                                              line_1: '123 Test St',
                                              line_2: nil,
                                              city: 'Irontown',
                                              state: 'OH',
                                              zip_code: '43214',
                                              zip_4: nil
                                            },
                                            members_attributes:[{
                                              first_name: 'Turanga',
                                              middle_name: nil,
                                              last_name: 'Leela',
                                              date_of_birth: DateTime.parse('31/08/1991'),
                                              is_head_of_household: true,
                                              email: 'tleela@test.com'
                                            }]
                                          }
      end.to change(Household, :count).by(1)
    end

    it 'shows the current user household' do
      
      get 'api/households'
      
      expect(response.status).to eq(200)
      response_body = JSON.parse(response.body)
      expect(response_body).to eq(household)
    end

    it 'updates the current user household attributes' do
      skip
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
      expect(response_body.name).to eq(updated_name)
      expect(response_body.number).to eq(updated_number)
    end

    it 'deletes a household' do
      skip
      expect do
        delete "/api/households/#{household.id}"
      end.to change(Household, :count).by(1)
    end

    it 'does not show another user household' do
      skip
      get "/api/households/#{other_household.id}"
      expect(response.status).to eq(404)
    end
  end

  context 'without authenticated requests' do
    it 'responds with unauthorized' do
      skip
      get '/api/households'
      expect(response.status).to eq(401)

      put '/api/households', household: { name: 'Haunted House' }
      expect(response.status).to eq(401)

      post '/api/households', household: { name: 'Haunted House' }
      expect(response.status).to eq(401)

      delete "/api/households/#{household.id}"
      expect(response.status).to eq(401)
    end
  end
end
