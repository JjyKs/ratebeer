class Beer < ActiveRecord::Base
  #toimiiko git?
  include RatingAverage
  belongs_to :brewery
  has_many :ratings, dependent: :destroy
  has_many :raters, through: :ratings, source: :user


  validates :name, length: { minimum: 1 }


  def to_s
    "#{self.brewery.name}in  #{self.name}"
  end
end
