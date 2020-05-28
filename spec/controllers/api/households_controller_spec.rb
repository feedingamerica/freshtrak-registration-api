# frozen_string_literal: true

describe Api::HouseholdsController, type: :controller do
    let(:freshtrak_registration_api) { instance_double(FreshtrakRegistrationApi) }
    context 'with authenticated requests' do
        # Will need a user object when auth becomes active
        
        it 'adds a household for a user' do
            skip
            # params = {
            #     household_name: 'Big Tester', 
            #     household_number: 1,
            #     address_attributes: {
            #     address_line_1: "123 Test St",
            #     address_line_2: "Suite 1",
            #         city: "Irontown",
            #         state: "OH",
            #         zip_code: "45805",
            #         zip_4: "12341"
            #         }
            #     }
            # post '/api/households'
            
            # expect(response.status).to eq(200)
            # expect(JSON.parse(response.body)).to eq(params)
        end

        it 'shows the current user household' do
            skip
        end

        it 'updates the household' do
            skip
            # params = {
            #     household_number: 5,
            #     household_name: 'Turanga'
            # }

            # put '/api/households'
        end

        it 'updates the household address' do
            skip
            # params = {address_line_1: '123 Test St.', address_line_2:'suite 3', city: 'Irontown',
            #           state: 'OH', zip_code: '45805', zip_4: '1234'}
            # put '/api/households/'
        end

        it 'deletes a household' do
            skip
        end
    end
end    

