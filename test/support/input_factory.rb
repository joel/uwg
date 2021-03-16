# frozen_string_literal: true

module InputFactory
  def input(name)
    "#{name.to_s.capitalize}Input"
      .constantize.new(attributes_for(name))
  end
end
