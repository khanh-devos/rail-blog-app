require 'spec_helper'
require 'rails_helper'

RSpec.describe User do
  context 'Text class User: ' do
    before :each do
      @name = 'Khanh'
      @bio = 'Saigon'
      @user = User.new(name: @name, bio: @bio)
    end

    it 'test all attrs' do
      expect(@user.name).to eql(@name)
      expect(@user.bio).to eql(@bio)
      expect(@user.postCounter).to eql(nil)
    end

    it 'validate invalid blank name' do
      user1 = User.new(name: nil, bio: 'bio', postCounter: 1)
      expect(user1).to be_invalid
    end

    it 'validate postCounter greater_than_or_equal_to 0' do
      user2 = User.new(name: @name, bio: 'bio', postCounter: -1)
      expect(user2).to be_invalid
    end
  end
end
