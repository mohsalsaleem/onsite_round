class CreateLeaderboards < ActiveRecord::Migration
  def change
    create_table :leaderboards do |t|
      t.string :user_email
      t.integer :score

      t.timestamps null: false
    end
  end
end
