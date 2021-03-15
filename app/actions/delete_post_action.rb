class DeletePostAction < Upgrow::Action
  def perform(id)
    PostRepository.new.delete(id)
    result.success
  end
end
