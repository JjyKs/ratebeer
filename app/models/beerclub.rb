class Beerclub < ActiveRecord::Base
  has_many :memberships
  has_many :members, through: :memberships, source: :user


  def to_s
    "#{self.name}, #{self.city}, #{self.founded}"
  end
end
