# frozen_string_literal: true

require "test_helper"

class DeletePostActionTest < ActiveSupport::TestCase
  test "delete record" do
    post = create(:post)
    assert_difference("PostRecord.count", -1) do
      DeletePostAction.new.perform(post.id)
    end
  end
end
