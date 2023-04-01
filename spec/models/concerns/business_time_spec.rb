require 'business_time'
require 'timecop'

RSpec.describe BusinessTime do
  describe '.during_business_hours?' do
    let(:start_time) { Time.parse('2023-04-03 09:00:00') } # Monday
    let(:end_time) { Time.parse('2023-04-03 18:00:00') }

    context 'when within work hours on a business day' do
      it 'returns true' do
        Timecop.freeze(start_time) do
          expect(start_time.during_business_hours?).to be_truthy
        end
      end
    end

    context 'when outside of work hours on a weekday' do
      let(:after_work_hours) { Time.parse('2023-04-03 19:00:00') }

      it 'returns false' do
        Timecop.freeze(after_work_hours) do
          expect(after_work_hours.during_business_hours?).to be_falsy
        end
      end
    end

    context 'when on a holiday' do
      let(:holiday) { Time.parse('2023-01-01 10:00:00') }

      it 'returns false' do
        Timecop.freeze(holiday) do
          expect(holiday.during_business_hours?).to be_falsy
        end
      end
    end
  end
end
