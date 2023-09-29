require 'test_helper'

class PostTest < ActiveSupport::TestCase
  test "method recent_5_comments" do
    p1 = posts(:one)
    assert_equal 5, p1.recent_5_comments.size
    assert_equal 'MyText6', p1.recent_5_comments.first.text  
  end

end
