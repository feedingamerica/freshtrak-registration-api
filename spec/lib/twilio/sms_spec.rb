# frozen_string_literal: true

describe Twilio::Sms do
  let(:twilio_rest_client) { instance_double(Twilio::REST::Client) }
  let(:twilio_message) { instance_double('twilio message') }
  let(:sender_no) { '1234567890' }
  let(:recipent_no) { '1234567890' }
  let(:message) { 'Sucessfully registered' }

  context 'with post request' do
    before do
      allow(Twilio::REST::Client).to receive(:new)
        .and_return(twilio_rest_client)
      allow(twilio_rest_client).to receive(:messages).and_return(twilio_message)
      allow(twilio_message).to receive(:create).and_return true
    end

    it 'sends message to recipent' do
      subject = described_class.new(sender_no, recipent_no, message).call
      expect(subject.success?).to eq(true)
    end
  end

  context 'with invalid request' do
    it "doesn't sends message to recipent" do
      subject = described_class.new(sender_no, recipent_no, message).call
      expect(subject.success?).to eq(false)
    end
  end
end
