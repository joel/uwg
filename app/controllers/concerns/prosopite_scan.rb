# frozen_string_literal: true

module ProsopiteScan
  extend ActiveSupport::Concern

  included do
    before_action :p_scan, unless: Rails.env.production?
    after_action :p_finish, unless: Rails.env.production?
  end

  private
    def p_scan
      Prosopite.scan
    end

    def p_finish
      Prosopite.finish
    end
end