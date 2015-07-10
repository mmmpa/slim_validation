class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
      t.string :slim
      t.string :slim_no_options
      t.string :slim_proc
      t.string :slim_attribute
      t.string :slim_scope
      t.string :html

      t.timestamps
    end
  end
end
