# frozen_string_literal: true

describe Api::HouseholdsController, type: :controller do
    let(:freshtrak_registration_api) { instance_double(FreshtrakRegistrationApi) }
    
    context 'with authenticated requests' do
        skip 'requires a user entity and auth'
        
        it 'adds a household for a user' do
        end
    
        it 'shows the current user household' do
        end

        it 'updates the current user household' do
        end

        it 'deletes a household' do
        end

        it 'does not show another user household' do
        end
    end

    context 'without authenticated requests' do
        skip 'requires a user entity and auth'

        it 'responds with unauthorized' do
        end
    end
end    

