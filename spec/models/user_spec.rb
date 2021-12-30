require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'relationships' do
    it { should belong_to :company }
    it { should have_many :absences }
    it { should have_many :attendances }
  end
end