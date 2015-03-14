class RestaurantSerializer < ActiveModel::Serializer
  embed :ids, include: true
  attributes :id, :name
  has_one :client, key: 'user_id', root: 'users', serializer: UserSerializer
  has_one :menu
end
