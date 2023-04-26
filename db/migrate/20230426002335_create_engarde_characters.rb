class CreateEngardeCharacters < ActiveRecord::Migration[7.0]
  def change
    create_table :engarde_characters do |t|
      t.integer :str
      t.integer :con
      t.integer :end
      t.integer :exp
      t.integer :ma
      t.integer :social_level
      t.string :name
      t.string :birth_class
      t.string :birth_rank
      t.string :position
      t.integer :allowance
      t.integer :initial_funds
      t.integer :inheritance
      t.timestamps
    end
  end
end
