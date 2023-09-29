require 'test_helper'

class LikeTest < ActiveSupport::TestCase
  test 'attrs' do
    assert 2, Like.all.size
  end

  test 'association' do
    assert users(:one).id, Like.first.user_id
    assert posts(:one).id, Like.first.post_id
  end
end
