require 'spec_helper'

RSpec.describe Comment do
  before :each do
    @text = 'text'
    @comment = Comment.new(text: @text)
  end

  it 'test attrs' do
    expect(@comment.text).to eql(@text)
  end
end
