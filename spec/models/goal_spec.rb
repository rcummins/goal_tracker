require 'rails_helper'

RSpec.describe Goal, type: :model do
  subject(:goal) { FactoryBot.build(:goal) }

  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:is_private) }
    it { should validate_presence_of(:completed) }
  end

  describe 'associations' do
    it { should belong_to(:user) }
  end
end
