# frozen_string_literal: true

class Post < ApplicationRecord
  validates :title, presence: true, uniqueness: true, length: {in: 6..80}
  validates :body, presence: true, length: {minimum: 10}
end
