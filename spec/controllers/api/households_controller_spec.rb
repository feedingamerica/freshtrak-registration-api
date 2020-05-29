# frozen_string_literal: true

describe Api::HouseholdsController, type: :controller do
  let(:freshtrak_registration_api) { instance_double(FreshtrakRegistrationApi) }

  context 'with authenticated requests' do
    skip 'requires a user entity and auth'

    it 'adds a household for a user' do
      # TODO
    end

    # it 'shows the current user household' do
    #   # TODO
    # end

    # it 'updates the current user household' do
    #   # TODO
    # end

    # it 'deletes a household' do
    #   # TODO
    # end

    # it 'does not show another user household' do
    #   # TODO
    # end
  end

  context 'without authenticated requests' do
    skip 'requires a user entity and auth'

    it 'responds with unauthorized' do
      # TODO
    end
  end
end
