class Friendship < ApplicationRecord
  belongs_to :sent_to, class_name: ‘User’, foreign_key: ‘sent_to_id’
  belongs_to :sent_by, class_name: ‘User’, foreign_key: ‘sent_by_id’
  scope :friends, -> { where(‘status =?’, true) }
  scope :not_friends, -> { where(‘status =?’, false) }
  has_many :friends, -> { merge(Friendship.friends) },
         through: :friend_sent, source: :sent_to
  has_many :pending_requests, -> { merge(Friendship.not_friends)},
         through: :friend_sent, source: :sent_to
  has_many :received_requests, -> { merge(Friendship.not_friends)},
         through: :friend_request, source: :sent_by

end
