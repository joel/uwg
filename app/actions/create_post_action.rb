# frozen_string_literal: true

class CreatePostAction < Upgrow::Action
  result :post

  def perform(input)
    if input.valid?
      post = PostRepository.new.create(input)
      PostsChannel.broadcast(post)
      result.success(post: post)
    else
      result.failure(input.errors)
    end
  end
end
