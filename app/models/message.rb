class Message < ApplicationRecord
	belongs_to :sender, class_name: 'User'
	belongs_to :recepient, class_name: 'User'

	scope :unread, -> {where(read_at: nil)}

	validates :body, presence: true

	def mark_as_read!
		self.read_at Time.now
		save!
	end

	def read?
		read_at
	end
end
