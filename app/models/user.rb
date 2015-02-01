class User < ActiveRecord::Base
  include RatingAverage

  has_secure_password

  validates :username, uniqueness: true,
            length: {minimum: 3, maximum: 15}
  validates :password, length: {minimum: 4}
  validates :password, :format => {:with => /[A-Z]/,
                                   message: "must have atleast one capitalized character"}
  validates :password, :format => {:with => /[0-9]/,
                                   message: "must have atleast one number"}
  has_many :ratings
  has_many :beers, through: :ratings
  has_many :memberships
  has_many :beerclubs, through: :memberships
end
