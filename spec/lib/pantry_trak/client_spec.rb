# frozen_string_literal: true

describe PantryTrak::Client do
  let(:base_url) { 'http://test.com' }
  let(:stubs) { Faraday::Adapter::Test::Stubs.new }

  it 'creates reservation on post request' do
    allow(Faraday).to receive(:new).and_return(conn)
    stubs.post('api/create_freshtrak_reservation_beta.php') do
      [
        200,
        { 'Content-Type' => 'application/json' },
        reservation_post_data
      ]
    end
    response = described_class.new.create_reservation(1271, '1', '7343', nil)
    response.should == reservation_post_data
  end

  it 'creates user on post request' do
    allow(Faraday).to receive(:new).and_return(conn)
    stubs.post('api/create_freshtrak_user_beta.php') do
      [
        200,
        { 'Content-Type' => 'application/json' },
        user_post_data
      ]
    end
    response = described_class.new.create_user('guest')
    response.should == user_post_data
  end

  it 'configures and returns json format' do
    client = described_class.new.send(:connection)
    expect(client.adapter).to eq Faraday::Adapter::NetHttp
  end

  def conn
    Faraday.new(url: base_url) do |config|
      config.request :json
      config.response :raise_error
      config.response :json, parser_options: { symbolize_names: true },
                             content_type: /\bjson$/
      config.adapter :test, stubs
    end
  end

  def reservation_post_data
    {
      'id' => 485,
      'user_id' => 1290,
      'event_date_id' => 80,
      'event_slot_id' => nil
    }
  end

  def user_post_data
    { 'user_type' => 'guest' }
  end
end
