# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  username        :string           not null
#  session_token   :string           not null
#  password_digest :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
require 'rails_helper'

RSpec.describe User, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"


  it { should validate_presence_of(:username) }
  it { should validate_presence_of(:password_digest) }
  it { should validate_presence_of(:session_token) }
  it { should validate_length_of(:password).is_at_least(6)}

  describe 'uniqueness' do
    before :each do 
        create(:user)
    end
    
    it { should validate_uniqueness_of(:username) }
    it { should validate_uniqueness_of(:session_token) }
  end

    describe 'is_password?' do 
    let(:user) { create(:user) }

        context "with a vaild password" do 
            it "should return true" do 
                expect(user.is_password?('password')).to be true
            end
        end

        context "with an invalid password" do 
            it "should return false" do 
                expect(user.is_password?('passowrd')).to be false
            end
        end

    end

    describe "password security" do 

        it 'does not save password to the database' do 
            FactoryBot.create(:legolas)
            user = User.find_by(username: 'Legolas')
            expect(user.password).not_to eq('password')
        end

        it 'secures password using BCrypt' do 
            expect(BCrypt::Password).to receive(:create).with('cheezit')

            FactoryBot.build(:user, password: 'cheezit')
        end

    end

    describe "self.find_by_credentials" do

        it "should find user by username" do 
            FactoryBot.create(:legolas)
            user = User.find_by(username: 'Legolas')
            expect(User.find_by_credentials(username: 'Legolas', password: 'password' )).to eq(user)
        end

        it "should return nil if password parameter does not match password of user" do
        FactoryBot.create(:legolas)
        user = User.find_by(username: 'Legolas')
        expect(User.find_by_credentials(username: 'Legolas', password: 'passrd' )).to be nil
        end

    end

    

end
