class RestaurantSerializer < ActiveModel::Serializer
  embed :ids, include: true
  attributes :name
  has_one :client, key: 'user_id', root: 'users', serializer: UserSerializer
end
