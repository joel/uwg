# frozen_string_literal: true

require "test_helper"

class PostInputTest < ActiveSupport::TestCase
  test "the validations" do
    post = PostInput.new
    assert_not post.valid?
    assert_match /can't be blank/, post.errors.messages[:title].join
    assert_match /can't be blank/, post.errors.messages[:body].join
  end
end
