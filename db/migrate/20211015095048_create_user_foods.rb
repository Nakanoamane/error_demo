class CreateUserFoods < ActiveRecord::Migration[5.0]
  def change
    create_table :user_foods do |t|
      t.references :user
      t.references :food
      t.timestamps
    end
  end
end
