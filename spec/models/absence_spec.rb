require 'rails_helper'

RSpec.describe Absence, type: :model do
  describe 'relationships' do
    it { should belong_to :user }
  end
end