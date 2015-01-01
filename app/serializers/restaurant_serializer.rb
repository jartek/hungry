class RestaurantSerializer < ActiveModel::Serializer
  embed :ids, include: true
  attributes :name
  has_one :client, serializer: UserSerializer
end
