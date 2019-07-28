class CreateAthletes < ActiveRecord::Migration[5.2]
  def change
    create_table :athletes do |t|
      t.string :name
      t.string :sex
      t.integer :age
      t.integer :height
      t.integer :weight
      t.string :team
      t.string :games
      t.string :sport

      t.timestamps
    end
    add_index :athletes, :name, unique: true
  end
end
