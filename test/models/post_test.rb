# frozen_string_literal: true

require "test_helper"

class PostTest < ActiveSupport::TestCase
  test "attributes" do
    post = Post.new(**build(:post).attributes.symbolize_keys.except(:lock_version))
    %i[id created_at updated_at title body].each do |attribute|
      assert post.respond_to?(attribute)
    end
  end
end
