class TheatreSerializer < ActiveModel::Serializer
  attributes :id, :name, :address, :user_id
end
