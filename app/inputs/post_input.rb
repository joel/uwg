# app/inputs/post_input.rb

class PostInput < Upgrow::Input
  attr_accessor :title, :body

  validates :title, presence: true, length: {in: 6..80}
  validates :body, presence: true, length: {minimum: 10}
end
