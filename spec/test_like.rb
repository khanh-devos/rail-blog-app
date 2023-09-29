require 'spec_helper'

RSpec.describe Like do
  context 'Test class Like: ' do
    before :each do
      @like = Like.new(user_id: 1, post_id: 2)
    end

    it 'test attrs' do
      expect(@like.user_id).to eql(1)
      expect(@like.post_id).to eql(2)
    end
  end
end
