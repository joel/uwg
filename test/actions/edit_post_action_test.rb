# frozen_string_literal: true

require "test_helper"

class EditPostActionTest < ActiveSupport::TestCase
  test "edit record" do
    post = create(:post)

    edit_post = EditPostAction.new.perform(post.id).post

    assert edit_post, post
  end
end
