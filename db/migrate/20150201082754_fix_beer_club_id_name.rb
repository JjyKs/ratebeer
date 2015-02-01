class FixBeerClubIdName < ActiveRecord::Migration
  def change
    rename_column :memberships, :beer_club_id, :beerclub_id
  end
end
