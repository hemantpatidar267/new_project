class TheatreSerializer < ActiveModel::Serializer
  attributes :id, :name, :address, :image

  def image
    object.image.url
  end
end
