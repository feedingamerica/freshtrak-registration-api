# frozen_string_literal: true

describe FacebookApi do
  let(:url) { 'https://test.facebook.com' }
  let(:facebook_api) { described_class.new(url: url) }
  let(:stubs) { Faraday::Adapter::Test::Stubs.new }
  let(:token) { 'token sample' }
  let(:app_id) { '338556869977' }
  let(:app_secret) { '7458bghrg41106n54thyjygf' }
  let(:user_id) { '123456' }

  it 'returns facebook response' do
    allow(Faraday).to receive(:new).and_return(conn)
    stubs.get('/debug_token?access_token=%7C&input_token=token+sample') do
      [
        200,
        { 'Content-Type' => 'application/json;charset=utf-8' },
        fb_response
      ]
    end
    response = facebook_api.facebook_auth(token, user_id)
    expect(response).to be_truthy
  end

  it 'configures and returns json format' do
    client = facebook_api.send(:client)
    expect(client.adapter).to eq Faraday::Adapter::NetHttp
  end

  def conn
    Faraday.new(url: url) do |config|
      config.request :json
      config.response :json, parser_options: { symbolize_names: true },
                             content_type: /\bjson$/
      config.adapter :test, stubs
    end
  end

  def fb_response
    {
      data: { app_id: app_id, user_id: user_id }
    }
  end
end
