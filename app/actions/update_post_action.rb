# frozen_string_literal: true

class UpdatePostAction < Upgrow::Action
  result :post

  def perform(id, input)
    if input.valid?
      post = PostRepository.new.update(id, input)
      result.success(post: post)
    else
      result.failure(input.errors)
    end
  end
end
