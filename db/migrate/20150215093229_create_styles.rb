class CreateStyles < ActiveRecord::Migration
  def change
    create_table :styles do |t|
      t.string :name
      t.text :description
      t.timestamps
    end

    rename_column :beers, :style, :old_style
    add_column :beers, :style_id, :integer

    Beer.all.each do |beer|
      if Style.where(name: beer.old_style).empty?
        s = Style.new
        s.description = "TESTIKUVAUS :-D"
        s.name = beer.old_style
        s.save
      end
      beer.style_id = Style.where(name: beer.old_style).first.id
      beer.save!
    end
    remove_column :beers, :old_style
  end
end
