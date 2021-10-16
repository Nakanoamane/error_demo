class UserFood < ApplicationRecord
	belongs_to :user, optional: true
	belongs_to :food, optional: true
end