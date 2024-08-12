require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it 'is valid with valid attributes' do
      user = User.new(
        email: 'test@example.com',
        password: 'password123',
        password_confirmation: 'password123'
      )
      expect(user).to be_valid
    end

    it 'is not valid without an email' do
      user = User.new(email: nil)
      expect(user).to_not be_valid
    end

    it 'is not valid with an invalid email format' do
      user = User.new(email: 'invalid_email')
      expect(user).to_not be_valid
    end

    it 'is not valid without a password' do
      user = User.new(password: nil)
      expect(user).to_not be_valid
    end

    it 'is not valid with a short password' do
      user = User.new(password: 'short', password_confirmation: 'short')
      expect(user).to_not be_valid
    end

    it 'is not valid when password and password_confirmation do not match' do
      user = User.new(
        email: 'test@example.com',
        password: 'password123',
        password_confirmation: 'differentpassword'
      )
      expect(user).to_not be_valid
    end
  end

  describe 'Devise modules' do
    it 'uses database_authenticatable module' do
      expect(User.devise_modules).to include(:database_authenticatable)
    end

    it 'uses recoverable module' do
      expect(User.devise_modules).to include(:recoverable)
    end

    it 'uses rememberable module' do
      expect(User.devise_modules).to include(:rememberable)
    end

    it 'uses validatable module' do
      expect(User.devise_modules).to include(:validatable)
    end
  end
end