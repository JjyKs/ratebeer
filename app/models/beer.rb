class Beer < ActiveRecord::Base
  #toimiiko git?
  include RatingAverage
  belongs_to :brewery
  belongs_to :style
  has_many :ratings, dependent: :destroy
  has_many :raters, through: :ratings, source: :user


  validates :name, length: { minimum: 1 }
  validates :style_id, presence: true


  def to_s
    "#{self.brewery.name}in  #{self.name}"
  end
end
