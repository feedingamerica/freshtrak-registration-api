# frozen_string_literal: true

describe Reservation, type: :model do
  let(:user) { User.create(user_type: :guest) }
  let(:reservation) { described_class.create(user: user, event_date_id: 1) }
  let(:start_time) { Time.current + 1.day }
  let(:message) { 'sms text' }
  let(:details) do
    {
      reservation: reservation, event_dates: {},
      start_time: start_time, message: message
    }
  end

  it 'sending remainders' do
    described_class.create(user: user, event_date_id: 1)
    allow(described_class).to receive(:send_reservstion_remainder)

    described_class.send_remainders
    expect(described_class).to have_received(:send_reservstion_remainder)
  end

  it 'send reservstion remainder' do
    allow(described_class).to receive(:fetch_event_info).and_return('1' => {})
    allow(described_class).to receive(:check_and_send_remainder)

    described_class.send_reservstion_remainder(details)
    expect(described_class).to have_received(:fetch_event_info)
    expect(described_class).to have_received(:check_and_send_remainder)
  end
end
