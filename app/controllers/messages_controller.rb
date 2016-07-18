class MessagesController < ApplicationController
  def new
  	@message = Message.new
  	unless @users = current_user.friends
		flash[:notice] = "You must have friends before send out message"
	end
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

  def sent_messages
  	@messages = current_user.sent_messages
  end

  def received_messages
  	@messages = current_user.received_messages
  end

  def show 
  	@message = Message.find(params[:id])
  	unless @message.recepient_id = current_user.id
  		flash[:error] = "You are not allow to view this message"
  		redirect_to users_path
  	end
  	@is_read = @message.read?
  	@message.mark_as_read!
  end

  private

  def message_params
  	params.require(:message).permit(:sender_id, :recepient_id, :body)
  end
end
