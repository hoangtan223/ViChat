class User < ApplicationRecord
	has_secure_password

	validates :name, presence: true
	validates :email, uniqueness: true

	has_many :sent_messages, foreign_key: 'sender_id', class_name: 'Message'
	has_many :received_messages, foreign_key: 'recepient_id', class_name: 'Message'

	has_many :relationships, foreign_key: 'user_id', class_name: 'Relationship'
	has_many :request_relationships, foreign_key: 'target_id', class_name: 'Relationship'

	has_many :targets, through: :relationships
	has_many :request_targets, through: :request_relationships, source: :user

	scope :all_except, -> (user) { where.not(id: user) }
	has_many :friends, -> {where(relationships: {status: 'friend'})}, through: :relationships, source: :target

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

	def get_relationship(user)
		if relationship = Relationship.where(target_id: user.id, user_id: id).take
			relationship.status
		end
	end	

	def send_friend_request(target_id)
		target = User.find(target_id)
		relationship = Relationship.new(user: self, target: target, status: "pending")
		self.relationships << relationship
	end

	def accept_friend_request(target_id)
		request = request_relationships.where(user_id: target_id).take
		request.status = "friend"
		request.save

		self.relationships << Relationship.new(user_id: id, target_id: target_id, status: "friend")
	end

	def all_friends

	end

	def gravatar
		"http://www.gravatar.com/avatar/#{Digest::MD5.hexdigest(email.downcase)}"
	end
end
