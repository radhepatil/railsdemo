class User < ApplicationRecord

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts

  has_many :friends

  has_many :comments, through: :posts, dependent: :destroy
  
  has_many :likes, through: :posts, dependent: :destroy



  has_many :friend_sent, class_name: 'Friendship',
                         foreign_key: 'sent_by_id',
                         inverse_of: 'sent_by',
                         dependent: :destroy

  has_many :friend_request, class_name: 'Friendship',
                         foreign_key: 'sent_to_id',
                         inverse_of: 'sent_to',
                         dependent: :destroy

  has_many :friends, -> { merge(Friendship.friends) },
           through: :friend_sent, source: :sent_to

  has_many :pending_requests, -> { merge(Friendship.not_friends) },
           through: :friend_sent, source: :sent_to

  has_many :received_requests, -> { merge(Friendship.not_friends) },
           through: :friend_request, source: :sent_by

  has_many :notifications, dependent: :destroy


  def full_name
    "#{firstname} #{lastname}"
  end
end
