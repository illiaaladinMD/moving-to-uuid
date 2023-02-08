class User < ApplicationRecord
  has_many :posts, dependent: :destroy
  has_many :reactions, dependent: :destroy
  
  has_many :followers, class_name: 'Following', foreign_key: 'following_id'
  has_many :followings, class_name: 'Following', foreign_key: 'follower_id'
end
