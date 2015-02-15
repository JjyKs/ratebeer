class Beerclub < ActiveRecord::Base
  has_many :memberships
  has_many :members, through: :memberships, source: :user


  def to_s
    "#{self.name}, #{self.city}, #{self.founded}"
  end

  def isMember (userID, clubID)
    return true if (Membership.where(user_id: userID).where(beerclub_id: clubID).first != nil)
  end
end
