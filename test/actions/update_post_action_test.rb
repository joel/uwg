# frozen_string_literal: true

require "test_helper"

class UpdatePostActionTest < ActiveSupport::TestCase
  test "update record" do
    post = create(:post)

    new_title = "This is a new title"

    input = PostInput.new({
      title: new_title,
      body: post.body
    })

    assert_changes -> { post.reload.title }, from: post.title, to: new_title do
      UpdatePostAction.new.perform(post.id, input)
    end
  end
end
