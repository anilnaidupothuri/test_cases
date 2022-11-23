# frozen_string_literal: true

class Micropost < ApplicationRecord
  belongs_to :user, touch: true
  has_many :comments, dependent: :destroy

  has_many :likes

  mount_uploader :picture, PictureUploader
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }

  after_create :micropost_created

  scope :recent, -> { where('created_at > ?', Time.now - 1.day) }
  scope :past_week, -> { where(created_at: Time.zone.now.at_beginning_of_week...Time.zone.now.at_end_of_week) }

  after_initialize do |_micropost|
    puts 'You have initialized an object!'
  end

  after_find do |_micropost|
    puts 'You have found an object!'
  end

  def micropost_created
    puts 'micropost has been created'
  end

  def liked?(user)
    !!likes.find { |like| like.user_id == user.id }
  end
end
