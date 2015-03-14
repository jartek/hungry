class MenuSerializer < ActiveModel::Serializer
  embed :ids, include: true
  attributes :id
  has_many :menu_items
end
