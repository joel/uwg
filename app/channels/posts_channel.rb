class PostsChannel < ApplicationCable::Channel
  def self.broadcast(post)
    broadcast_to "posts", post:
      PostsController.render(partial: "posts/post", locals: {post: post})
  end

  def subscribed
    Rails.logger.info("subscribed: stream_from posts:posts")
    stream_from "posts:posts"
  end

  def unsubscribed
    Rails.logger.info("unsubscribed: stream_from posts:posts")
    # Any cleanup needed when channel is unsubscribed
  end
end
