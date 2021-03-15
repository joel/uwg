# frozen_string_literal: true

require "test_helper"

class PostTest < ActiveSupport::TestCase
  test "attributes" do
    post = model(name: :post, exclude: %i[lock_version])
    %i[id created_at updated_at title body].each do |attribute|
      assert post.respond_to?(attribute)
    end
  end
end
