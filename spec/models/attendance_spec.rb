require 'rails_helper'

RSpec.describe Attendance, type: :model do
  describe 'relationships' do
    it { should belong_to :user }
  end

  describe 'validations' do
    it { should validate_presence_of :check }
    it { should define_enum_for(:check) }
    it { should define_enum_for(:check).with_values([:check_in, :check_out]) }
  end
end