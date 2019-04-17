class Api::V1::MessagesController < ApplicationController
  def create
    @user = User.find(message_params[:user_id])
    @message = Message.new(message_params)
    @message.user = @user
    @conversation = Conversation.find(message_params[:conversation_id])
    # byebug
    if @message.save
      serialized_data = ActiveModelSerializers::Adapter::Json.new(
        MessageSerializer.new(@message)
      ).serializable_hash
      MessagesChannel.broadcast_to @conversation, serialized_data
      head :ok
    end

  end

  private

  def message_params
    params.require(:message).permit(:text, :conversation_id, :user_id)
  end
end
