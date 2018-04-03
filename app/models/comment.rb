class Comment < ApplicationRecord
  belongs_to :entry
  validates :author, presence: true
  validates :comment, presence: true
end
