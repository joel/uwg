# frozen_string_literal: true

# Ensure validation of a Post
class PostRecord < ApplicationRecord
  self.table_name = "posts"

  validates :title, uniqueness: true
end
