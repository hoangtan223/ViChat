class MessagesController < ApplicationController
  def new
  	@message = Message.new
  	@users = User.all_except current_user
  end

  def create
  	@message = Message.new(message_params)
  	if @message.save
  		flash[:success] = "Message sent!"
  		redirect_to root_path
  	else
  		flash[:error] = @message.errors.full_messages.to_sentence
  		@users = User.all_except current_user
  		render 'new'
  	end
  end

  private

  def message_params
  	params.require(:message).permit(:sender_id, :recepient_id, :body)
  end
end
