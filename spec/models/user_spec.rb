require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }
    it { should validate_presence_of(:password) }
    it { should have_secure_password }

    it 'should not store the password as plain text' do
      user = User.create(
        name: 'Meg',
        email: 'meg@test.com',
        password: 'password123',
        password_confirmation: 'password123'
      )

      expect(user.attributes).to_not include('password')
      expect(user.password_digest).to_not eq('password123')
      expect(user.password_digest).to_not be_nil
    end
  end
end
