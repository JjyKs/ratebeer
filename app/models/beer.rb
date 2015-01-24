class Beer < ActiveRecord::Base
  #toimiiko git?
  include RatingAverage
  belongs_to :brewery
  has_many :ratings, dependent: :destroy



  def to_s
    "#{self.brewery.name}in  #{self.name}"
  end
end
