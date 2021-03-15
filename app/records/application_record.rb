# frozen_string_literal: true

require "securerandom"

class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  # Sort records by date of creation instead of primary key
  self.implicit_order_column = :created_at

  after_initialize :add_uuid, if: :new_record?

  private

  def add_uuid
    self.id ||= SecureRandom.uuid
  end
end
