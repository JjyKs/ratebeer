module AverageRating
  def average_rating
    score = self.ratings.count(:score)
    "Has #{score} #{"rating".pluralize(score)}, average #{self.ratings.average(:score)}"
  end
end