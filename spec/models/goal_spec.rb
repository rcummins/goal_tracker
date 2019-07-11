require 'rails_helper'

RSpec.describe Goal, type: :model do
  subject(:goal) { FactoryBot.build(:goal) }

  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:privacy) }
    it { should validate_presence_of(:completion) }
    it { should validate_inclusion_of(:privacy).in_array(['Public', 'Private']) }
    it { should validate_inclusion_of(:completion).in_array(
      ['Not completed', 'Completed']) }
  end

  describe 'associations' do
    it { should belong_to(:user) }
  end
end
