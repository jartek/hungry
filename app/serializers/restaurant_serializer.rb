class RestaurantSerializer < ActiveModel::Serializer
  embed :ids, include: true
  attributes :name, :id
  has_one :client, key: 'user_id', root: 'users', serializer: UserSerializer
  has_one :menu
end
