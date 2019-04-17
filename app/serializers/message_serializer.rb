class MessageSerializer < ActiveModel::Serializer
  attributes :id, :conversation_id, :text, :created_at , :user
  def user
    ActiveModel::SerializableResource.new(object.user,  each_serializer: UserSerializer)
  end
end
