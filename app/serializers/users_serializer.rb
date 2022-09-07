class UsersSerializer < ActiveModel::Serializer
  attributes :id, :firstname, :lastname, :created_at, :updated_at
  has_many :posts, serializer: PostsSerializer
  has_many :comments, serializer: CommentsSerializer
end
