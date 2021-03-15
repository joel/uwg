# app/repositories/posts_repository.rb

class PostRepository
  def all
    PostRecord.order(:created_at).all.map { |record| to_model(record.attributes) }
  end

  def create(input)
    record = PostRecord.create!(title: input.title, body: input.body)
    to_model(record.attributes)
  end

  def find(id)
    record = PostRecord.find(id)
    to_model(record.attributes)
  end

  def update(id, input)
    record = PostRecord.find(id)
    record.update!(title: input.title, body: input.body)
    to_model(record.attributes)
  end

  def delete(id)
    record = PostRecord.find(id)
    record.destroy!
  end

  private

  def to_model(attributes)
    Post.new(**attributes.symbolize_keys.except(:lock_version))
  end
end
