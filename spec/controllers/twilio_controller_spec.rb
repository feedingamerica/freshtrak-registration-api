# frozen_string_literal: true

describe TwilioController, type: :controller do
  let(:twilio_sms) { instance_double(Twilio::Sms) }
  let(:params) do
    {
      phone: '1234567890',
      message: 'Sucessfully registered'
    }
  end

  context 'with suceessful api' do
    before do
      allow(Twilio::Sms).to receive(:new).and_return(twilio_sms)
      allow(twilio_sms).to receive(:call)
        .and_return(OpenStruct.new(success?: true))
    end

    it ' responds with sms sent as true' do
      post 'twilio/sms', params: params
      expect(JSON.parse(response.body)['sms_sent']).to eq(true)
    end
  end

  context 'with unsuceessful api' do
    before do
      allow(Twilio::Sms).to receive(:new).and_return(twilio_sms)
      allow(twilio_sms).to receive(:call)
        .and_return(OpenStruct.new(success?: false))
    end

    it 'responds with unauthorized' do
      post 'twilio/sms', params: params
      expect(response.status).to eq(422)
    end
  end
end
