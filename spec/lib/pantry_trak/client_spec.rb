# frozen_string_literal: true

describe PantryTrak::Client do
  let(:base_url) { 'http://test.com' }
  let(:error_msg) { 'Error raised on logging' }
  let(:stubs) { Faraday::Adapter::Test::Stubs.new }

  context 'with post request' do
    it 'creates reservation in pantrytrak' do
      allow(Faraday).to receive(:new).and_return(conn)
      stubs.post('api/create_freshtrak_reservation.php') do
        [
          200,
          { 'Content-Type' => 'application/json' },
          reservation_post_data
        ]
      end
      response = described_class.new.create_reservation(1271, '1', '7343', nil)
      response.should == reservation_post_data
    end

    it 'creates user in pantrytrak' do
      allow(Faraday).to receive(:new).and_return(conn)
      stubs.post('api/create_freshtrak_user.php') do
        [
          200,
          { 'Content-Type' => 'application/json' },
          user_post_data
        ]
      end
      response = described_class.new.create_user('guest')
      response.should == user_post_data
    end
  end

  context 'with pantrytrak prod url' do
    let(:prod_mock_env) { instance_double('env', production?: true) }

    before do
      allow(Jets).to receive(:env) { prod_mock_env }
    end

    it 'returns url that creates freshtrak user' do
      subject = described_class.new.send(:create_user_path)
      expect(subject).to eq 'api/create_freshtrak_user.php'
    end

    it 'returns url that creates freshtrak reservation' do
      subject = described_class.new.send(:create_reservation_path)
      expect(subject).to eq 'api/create_freshtrak_reservation.php'
    end
  end

  context 'with exception handling' do
    let(:mock_logger) { instance_double('logger', error: error_msg) }

    before do
      allow(Jets).to receive(:logger) { mock_logger }
    end

    it 'returns error on creating reservation' do
      response = described_class.new.create_reservation(1271, '1', '7343', nil)
      expect(response).to eq error_msg
    end

    it 'returns error on creating user ' do
      response = described_class.new.create_user('guest')
      expect(response).to eq error_msg
    end
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
