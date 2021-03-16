# frozen_string_literal: true

require "test_helper"

class ShowPostActionTest < ActiveSupport::TestCase
  test "show record" do
    post = create(:post)

    show_post = ShowPostAction.new.perform(post.id).post

    assert show_post, post
  end
end
