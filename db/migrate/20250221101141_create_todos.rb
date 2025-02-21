class CreateTodos < ActiveRecord::Migration[8.0]
  def change
    create_table :todos do |t|
      t.string :title
      t.text :content
      t.string :is_completed
      t.string :boolean

      t.timestamps
    end
  end
end
