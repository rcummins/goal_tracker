require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user) do
    FactoryBot.build(:user, username: 'renata', password: 'good_password')
  end

  describe 'validations' do
    it { should validate_presence_of(:username) }
    it { should validate_uniqueness_of(:username) }
    it { should validate_presence_of(:password_digest) }
    it { should validate_presence_of(:session_token) }
    it { should validate_uniqueness_of(:session_token) }
    it { should validate_length_of(:password).is_at_least(8) }
  end

  describe 'associations' do
    it { should have_many(:goals) }
  end

  describe 'methods' do
    describe '::find_by_credentials' do
      before(:each) { user.save! }
      
      context 'when given correct credentials' do
        it 'finds the user' do
          expect(User.find_by_credentials('renata', 'good_password')).to eq(user)
        end
      end

      context 'when given incorrect credentials' do
        it 'returns nil' do
          expect(User.find_by_credentials('renata', 'bad_password')).to be nil
        end
      end
    end

    describe '#initialize' do
      it 'sets session_token' do
        expect(user.session_token).not_to be nil
      end

      it 'sets password_digest' do
        expect(user.password_digest).not_to be nil
      end
    end

    describe '#reset_session_token!' do
      it "changes the user's session_token" do
        previous_token = user.session_token
        user.reset_session_token!
        expect(user.session_token).not_to eq(previous_token)
      end

      it 'saves the user after changing their session token' do
        user.save!
        previous_token = user.session_token
        user.reset_session_token!
        saved_user = User.find_by(username: user.username)
        expect(saved_user.session_token).not_to eq(previous_token)
      end

      it 'returns the new session_token' do
        new_token = user.reset_session_token!
        expect(user.session_token).to eq(new_token)
      end
    end

    describe '#is_password?' do
      context 'when the password is correct' do
        it 'returns true' do
          expect(user.is_password?('good_password')).to be true
        end
      end

      context 'when the password is not correct' do
        it 'returns false' do
          expect(user.is_password?('bad_password')).to be false
        end
      end
    end
  end
end
