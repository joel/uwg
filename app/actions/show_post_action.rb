class ShowPostAction < Upgrow::Action
  result :post

  def perform(id)
    post = PostRepository.new.find(id)

    result.success(post: post)
  end
end
