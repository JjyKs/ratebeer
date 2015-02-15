class Membership < ActiveRecord::Base
  belongs_to :user
  belongs_to :beerclub

  validate :no_duplicates

  def no_duplicates
    if (Membership.where(:user_id => user_id).where(:beerclub_id => beerclub_id).first != nil)
      errors.add(:user_id, "You are already a member of this club " )
    end
  end


end
