class UserSerializer < ActiveModel::Serializer
  attributes :id , :name, :password, :email, :role
end
