class Following < ApplicationRecord
  belongs_to :follower, class_name: 'User', primary_key: 'id'
  belongs_to :following, class_name: 'User', primary_key: 'id'
end
