module RatingAverage
  extend ActiveSupport::Concern
  def average_rating
    score = self.ratings.count(:score)
    return 'No ratings yet' if self.ratings.average(:score).nil?
    "Has #{score} #{"rating".pluralize(score)}, average #{self.ratings.average(:score).round(2)}"
  end

  #En jaksanut rikkoa testejä ..
  def average_rating_fix
    self.ratings.average(:score)
  end
end