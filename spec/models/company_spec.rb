require 'rails_helper'

RSpec.describe Company, type: :model do
  describe 'relationships' do
    it { should have_many :users }
  end
end