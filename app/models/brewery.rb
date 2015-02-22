class Brewery < ActiveRecord::Base
  include RatingAverage
  has_many :beers, dependent: :destroy
  has_many :ratings, through: :beers

  scope :active, -> { where active:true }
  scope :retired, -> { where active:[nil,false] }


  validates :name, length: {minimum: 1}
  validates :year, numericality: { greater_than_or_equal_to: 1024,
                                    only_integer: true }
  validate :year_must_be_lower_than_current_year


  def year_must_be_lower_than_current_year
    if year.present? && year > Time.now.year
      errors.add(:year, "can't be higher than " + Time.now.year.to_s )
    end
  end

  def self.top(n)
    sorted_by_rating_in_desc_order = Brewery.all.sort_by{ |b| -(b.average_rating_fix||0) }
    sorted_by_rating_in_desc_order[0, n]
  end


  def print_report
    puts name
    puts "established at #{year}"
    puts "number of beers #{beers.count}"
  end

  def restart
    self.year = 2015
    puts "changed year to #{year}"
  end


end
