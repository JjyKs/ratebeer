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

  def favorite_beer
    return nil if ratings.empty?
    ratings.order(score: :desc).limit(1).first.beer
  end

  def favorite_style
    return nil if Beer.first.nil? # Jos oluita ei ole, on hashi tyhjä, ja tuo .max_by sekoaa jotenkin.
    hash = {}
    Beer.select("style_id").group("style_id").each do |r|
      hash[r.style_id] = Rating.where(user_id: self.id, beer_id: Beer.where(style: r.style_id)).average(:score).to_s
    end
    "#{self.username}s favorite style is #{Style.where(id: hash.max_by{|k,v| v}[0]).first.name} with an #{hash.max_by{|k,v| v}[1]} average rating" if hash.max_by{|k,v| v}[1].present?;
  end

  def favorite_brewery
    return nil if Beer.first.nil?
    hash = {}
    Beer.select("brewery_id").group("brewery_id").each do |r|
      hash[r.brewery_id] = Rating.where(user_id: self.id, beer_id: Beer.where(brewery_id: r.brewery_id)).average(:score).to_s
    end
    "#{self.username}s favorite brewery is #{Brewery.find_by(id: hash.max_by{|k,v| v}[0]).name} with an #{hash.max_by{|k,v| v}[1]} average rating" if hash.max_by{|k,v| v}[1].present?;
  end
end
