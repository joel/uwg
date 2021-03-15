# frozen_string_literal: true

require "securerandom"
class Post < ApplicationRecord
  after_initialize :add_uuid, if: :new_record?

  validates :title, presence: true, uniqueness: true, length: {in: 6..80}
  validates :body, presence: true, length: {minimum: 10}

  private

  def add_uuid
    self.id ||= SecureRandom.uuid
  end
end
