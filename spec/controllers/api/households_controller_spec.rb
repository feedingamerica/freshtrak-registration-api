# frozen_string_literal: true

describe Api::HouseholdsController, type: :controller do
  let(:user) { User.create(user_type: :guest) }
  let(:member) { user.member.create(first_name: 'Phillip',
                                  last_name: 'Fry',
                                  date_of_birth: '08/31/1991',
                                  is_head_of_household: true,
                                  email: 'pfry@test.com')}
  let(:household) { member.household.create(number: 2, name: 'Fun House',
                                            address: {
                                              line_1: '123 Test St',
                                              line_2: nil,
                                              city: 'Irontown',
                                              state: 'OH',
                                              zip_code: '43214',
                                              zip_4: nil 
                                              })
                                            }

  let(:other_user) { User.create(user_type: :guest) }
  let(:other_member) { other_user.member.create(first_name: 'Bender',
                                              last_name: 'Rodriguez',
                                              date_of_birth: '08/31/1991',
                                              is_head_of_household: true,
                                              email: 'brodriguez@test.com') }
  let(:other_household) { other_member.household.create(number: 1, name: 'Unfun House',
                                                      address: {
                                                        line_1: '321 Limbo St',
                                                        line_2: nil,
                                                        city: 'Slabtown',
                                                        state: 'OH',
                                                        zip_code: '45805',
                                                        zip_4: nil
                                                      })
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
                                            member_attributes:[{
                                              first_name: 'Turanga',
                                              middle_name: nil,
                                              last_name: 'Leela',
                                              date_of_birth: '08/31/1991',
                                              is_head_of_household: true,
                                              email: 'tleela@test.com'
                                            }]
                                          }
                                          byebug
      end.to change(Household, :count).by(1)
    end

    it 'shows the current user household' do
      byebug

      get 'api/households'

      expect(response.status).to eq(200)
      response_body = JSON.parse(response.body)
      expect(response_body).to eq(household)
    end

    it 'updates the current user household attributes' do
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

      expect do
        delete "/api/households/#{household.id}"
      end.to change(Household, :count).by(1)
    end

    it 'does not show another user household' do
      get "/api/households/#{other_household.id}"
      expect(response.status).to eq(404)
    end
  end

  context 'without authenticated requests' do
    it 'responds with unauthorized' do
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
