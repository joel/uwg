# frozen_string_literal: true

require "test_helper"

class PostTest < ActiveSupport::TestCase
  test "the validations" do
    post = Post.new
    assert_not post.valid?
    assert_match /can't be blank/, post.errors.messages[:title].join
    assert_match /can't be blank/, post.errors.messages[:body].join
  end

  test "the factory" do
    assert build(:post).valid?
  end

  test "the pessimitic lock" do
    post = create(:post)

    post_user_john = Post.find(post.id)
    post_user_john.title = FFaker::Book.title

    post_user_jane = Post.find(post.id)
    post_user_jane.title = FFaker::Book.title

    post_user_jane.save!

    assert_raises(ActiveRecord::StaleObjectError, "Attempted to update a stale object: Post.") do
      post_user_john.save!
    end

    post_user_john.reload
    post_user_john.title = FFaker::Book.title
    assert post_user_john.save
  end

  test "eager uuid" do
    post = Post.new

    uuid = post.id

    post.assign_attributes(attributes_for(:post))

    post.save!

    assert_equal uuid, post.id
  end
end
