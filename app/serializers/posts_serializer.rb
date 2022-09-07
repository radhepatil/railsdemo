class PostsSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :title, :body
  has_many :comments, serializer: CommentsSerializer
end
