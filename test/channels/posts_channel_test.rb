require "test_helper"

class PostsChannelTest < ActionCable::Channel::TestCase
  test "subscribes" do
    subscribe
    assert subscription.confirmed?
    assert_has_stream "posts:posts"
  end

  test "broadcast post after create" do
    id = SecureRandom.uuid

    new_post_input = input(:post)
    new_post_input.stubs(:id).returns(id)

    partial = PostsController.render(partial: "posts/post", locals: {post: new_post_input})

    post_model = Post.new(
      id: id,
      title: new_post_input.title,
      body: new_post_input.body,
      created_at: Time.now,
      updated_at: Time.now
    )

    PostRepository.any_instance.stubs(:create).returns(post_model)

    assert_broadcast_on("posts:posts", post: partial) do
      CreatePostAction.new.perform(new_post_input)
    end
  end
end
