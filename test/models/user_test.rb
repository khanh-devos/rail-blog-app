require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'self.recent_posts' do
    arr = users(:one).recent_posts
    assert_equal 3, arr.length
    assert_equal 'MyString4', arr.first.title
  end

  test 'invalid blank name' do
    user = User.new(name: nil, bio: 'Saigon', postCounter: 1)
    assert_equal true, user.invalid?
  end

  test 'postCounter should be positive and integer only' do
    user1 = User.new(name: 'name', bio: 'Saigon', postCounter: -1)
    assert_equal true, user1.invalid?

    user2 = User.new(name: 'name', bio: 'Saigon', postCounter: 'xy')
    assert_equal true, user2.invalid?
  end
end
