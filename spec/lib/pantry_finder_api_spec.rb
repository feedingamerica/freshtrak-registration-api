# frozen_string_literal: true

describe PantryFinderApi do
  let(:url) { 'http://test.com' }
  let(:pantry_finder_api) { described_class.new(url: url) }
  let(:stubs) { Faraday::Adapter::Test::Stubs.new }
  let(:conn) { Faraday.new { |config| config.adapter :test, stubs } }

  before do
    allow(Faraday).to receive(:new).and_return(conn)
  end

  it 'returns event_date response' do
    stubs.get('api/event_dates/123') do
      [
        200,
        { 'Content-Type' => 'application/json;charset=utf-8' },
        event_date_response
      ]
    end
    response = pantry_finder_api.event_date('123')
    response.should == event_date_response[:event_date]
  end

  def event_date_response
    {
      event_date:
      {
        id: 1742, event_id: 1740, capacity: 100
      }
    }
  end
end
