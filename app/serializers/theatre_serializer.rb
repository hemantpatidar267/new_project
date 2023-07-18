class TheatreSerializer < ActiveModel::Serializer
  attributes :id, :name, :address, :user_id, :image

  def image
    object.image.url
  end
end
