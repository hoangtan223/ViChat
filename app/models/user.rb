class User < ApplicationRecord
	has_secure_password

	validates :name, presence: true
	validates :email, uniqueness: true

	has_many :sent_messages, foreign_key: 'sender_id', class_name: 'Message'
	has_many :received_messages, foreign_key: 'recepient_id', class_name: 'Message'
	scope :all_except, -> (user) { where.not(id: user) }

	def received_messages
		Message.where(recepient: self)
	end

	def sent_messages
		Message.where(sender: self)
	end

	def lastest_received_messages(n)
		received_messages.order(created_at: :desc).limit(n)
	end

	def unread_messages
		received_messages.unread
	end

	def gravatar
		"http://www.gravatar.com/avatar/#{Digest::MD5.hexdigest(email.downcase)}"
	end
end
