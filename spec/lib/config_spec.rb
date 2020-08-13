# frozen_string_literal: true

describe Config do
  let(:pantry_finder_api_url) { 'https://test.pantry-finder-api.freshtrak.com' }

  context 'with PANTRY_FINDER_API_URL' do
    before do
      ENV['PANTRY_FINDER_API_URL'] = pantry_finder_api_url
    end

    it 'returns url' do
      expect(described_class.pantry_finder_api_url).to eq pantry_finder_api_url
    end
  end
end
