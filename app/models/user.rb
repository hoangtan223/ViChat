class User < ApplicationRecord
	has_secure_password

	validates :name, presence: true
	validates :email, uniqueness: true

	has_many :sent_messages, foreign_key: 'sender_id', class_name: 'Message'
	has_many :received_messages, foreign_key: 'recepient_id', class_name: 'Message'
end
