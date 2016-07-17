class MessagesController < ApplicationController
  def new
  	@message = Message.new
  	@users = current_user.friends
  end

  def create
  	@message = Message.new(message_params)
  	if @message.save
  		flash[:success] = "Message sent!"
  		redirect_to root_path
  	else
  		flash[:error] = @message.errors.full_messages.to_sentence
  		@users = current_user.friends
  		render 'new'
  	end
  end

  private

  def message_params
  	params.require(:message).permit(:sender_id, :recepient_id, :body)
  end
end
