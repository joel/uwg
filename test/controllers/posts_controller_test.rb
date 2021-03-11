# frozen_string_literal: true

require "test_helper"

class PostsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    create(:post)
    get posts_url
    assert_response :success
  end

  test "should get new" do
    get new_post_url
    assert_response :success
  end

  test "should create post" do
    assert_difference("Post.count") do
      post posts_url, params: {post: {body: FFaker::Book.description, title: FFaker::Book.title}}
    end

    assert_redirected_to post_url(Post.last)
  end

  test "should show post" do
    post = create(:post)
    get post_url(post)
    assert_response :success
  end

  test "should get edit" do
    post = create(:post)
    get edit_post_url(post)
    assert_response :success
  end

  test "should update post" do
    post = create(:post)
    patch post_url(post), params: {post: {body: post.body, title: FFaker::Book.title}}
    assert_redirected_to post_url(post)
  end

  test "should destroy post" do
    post = create(:post)
    assert_difference("Post.count", -1) do
      delete post_url(post)
    end

    assert_redirected_to posts_url
  end
end
