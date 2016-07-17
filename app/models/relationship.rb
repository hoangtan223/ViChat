class Relationship < ApplicationRecord
	belongs_to :user, class_name: 'User'
	belongs_to :target, class_name: 'User'
end
