class ScreenSerializer < ActiveModel::Serializer
  attributes :id,:theatre_id, :seating_capacity, :movie_id
end
