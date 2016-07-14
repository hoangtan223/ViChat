class Message < ApplicationRecord
	belongs_to :sender, class_name: 'User'
	belongs_to :recepient, class_name: 'User'
end
