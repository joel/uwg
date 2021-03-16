# frozen_string_literal: true

require "test_helper"

class CreatePostActionTest < ActiveSupport::TestCase
  test "create record" do
    input = input(:post)

    assert_difference("PostRecord.count", +1) do
      CreatePostAction.new.perform(input)
    end
  end
end
