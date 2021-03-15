# frozen_string_literal: true

module ModelFactory
  def model(name:, exclude: [])
    name
      .to_s
      .capitalize
      .constantize.new(
        **build(name).attributes.symbolize_keys.except(*exclude)
      )
  end
end
