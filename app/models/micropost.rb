# frozen_string_literal: true

class Micropost < ApplicationRecord
  belongs_to :user
  mount_uploader :picture, PictureUploader
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }

  validate :picture_size
  after_create :micropost_created

  def micropost_created
    puts 'micropost has been created'
  end

  private

  # Validates the size of an uploaded picture.
  def picture_size
    return unless picture.size > 200.kilobytes

    errors.add(:picture, 'should be less than 5MB')
  end
end
