# frozen_string_literal: true

describe Reservation, type: :model do

    let(:user) { User.create(user_type: :guest) }
    let(:reservation) { described_class.create(user: user, event_date_id: 1) }
    let(:start_time) { Time.current + 1.day }
    let(:message) { "sms text" }
    let(:details) { { reservation: reservation, event_dates: {},
        start_time: start_time, message: message} }

    it 'sending remainders' do
        described_class.create(user: user, event_date_id: 1)
        allow(described_class).to receive(:send_reservstion_remainder)

        described_class.send_remainders
        expect(described_class).to have_received(:send_reservstion_remainder)
    end

    it 'send reservstion remainder' do
        allow(described_class).to receive(:fetch_event_info) { {'1' => {} } }
        allow(described_class).to receive(:check_and_send_remainder)
        described_class.send_reservstion_remainder(details)
        expect(described_class).to have_received(:fetch_event_info)
        expect(described_class).to have_received(:check_and_send_remainder)
    end

    it 'check and send remainder' do
        details[:event_date_data] = {event_date: {}}
        allow(described_class).to receive(:get_event_time) {Time.current}
        allow(described_class).to receive(:send_remainder)
        described_class.check_and_send_remainder(details)
        expect(described_class).to have_received(:get_event_time)
        expect(described_class).to have_received(:send_remainder)
    end

    context 'get event time' do
        let(:event_date) { {'date' => "2020-01-04", 'start_time' => "12 AM"}}
        let(:expected1) { Time.strptime("#{event_date['date']} #{event_date['start_time']}","%F %I %p") }
        let(:expected2) { Time.strptime("#{event_date['date']} #{event_date['start_time']}","%F %I:%M %p") }
        
        it 'get event time with hour' do
            expect(described_class.get_event_time(event_date)).to eq(expected1)
        end
        it 'get event time with hour and minutes' do
            event_date['start_time'] = '12:30 AM'
            expect(described_class.get_event_time(event_date)).to eq(expected2)
        end
    end

    context "send remainder" do
        let(:twilio_sms) { instance_double(Twilio::Sms) }

        before do
            allow(Twilio::Sms).to receive(:new).and_return(twilio_sms)
            allow(twilio_sms).to receive(:call)
              .and_return(OpenStruct.new(success?: true))
        end

        it 'when to number is present and send_sms flag is true' do
            described_class.send_remainder(reservation, '12345', "67890", "message", true)
            expect(twilio_sms).to have_received(:call)
        end

        it 'when to number is not present and send_sms flag is true' do
            described_class.send_remainder(reservation, '12345', nil, "message", true)
            expect(twilio_sms).not_to have_received(:call)
        end

        it 'when to number is present and send_sms flag is false' do
            described_class.send_remainder(reservation, '12345', "67890", "message", false)
            expect(twilio_sms).not_to have_received(:call)
        end

        it 'when to number is not present and send_sms flag is false' do
            described_class.send_remainder(reservation, '12345', nil, "message", false)
            expect(twilio_sms).not_to have_received(:call)
        end
    end

    context "fetch_event_info" do
        let(:event_date_id) { '123' }
        let(:event_dates) { {} }
        let(:success_response) { Net::HTTPSuccess.new(1.0, '200', 'OK') }
        let(:error_response) { Net::HTTPError.new('Error', '403') }

        before do
            allow(described_class).to receive(:update_cached_event_details)
        end

        it 'should receive success response and call update_cached_event_details' do
            expect_any_instance_of(Net::HTTP).to receive(:request) { success_response }
            expect(success_response).to receive(:body) { '{"events": [{}]}' }  

            described_class.fetch_event_info(event_dates, event_date_id)
            expect(described_class).to have_received(:update_cached_event_details)
        end

        it 'should receive success response and not call update_cached_event_details' do
            expect_any_instance_of(Net::HTTP).to receive(:request) { success_response }
            expect(success_response).to receive(:body) { '{"events": []}' }  

            described_class.fetch_event_info(event_dates, event_date_id)
            expect(described_class).not_to have_received(:update_cached_event_details)
        end

        it 'should receive success response and not call update_cached_event_details' do
            expect_any_instance_of(Net::HTTP).to receive(:request) { error_response } 

            described_class.fetch_event_info(event_dates, event_date_id)
            expect(described_class).not_to have_received(:update_cached_event_details)
        end
    end
end
  