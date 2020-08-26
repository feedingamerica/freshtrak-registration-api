# frozen_string_literal: true

describe PantryFinderApi do
  let(:url) { 'http://test.com' }
  let(:pantry_finder_api) { described_class.new(url: url) }
  let(:stubs) { Faraday::Adapter::Test::Stubs.new }

  it 'returns event_date response' do
    allow(Faraday).to receive(:new).and_return(conn)
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

  it 'configures and returns json format' do
    client = pantry_finder_api.send(:client)
    expect(client.adapter).to eq Faraday::Adapter::NetHttp
  end

  def conn
    Faraday.new(url: url) do |config|
      config.request :json
      config.response :raise_error
      config.response :json, parser_options: { symbolize_names: true },
                             content_type: /\bjson$/
      config.adapter :test, stubs
    end
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
