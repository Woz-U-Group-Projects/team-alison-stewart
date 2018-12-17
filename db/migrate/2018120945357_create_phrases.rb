class CreatePhrases < ActiveRecord::Migration
  def up
    create_table :phrases do |t|
      t.integer :node_id, null: false
      t.string  :name,    null: false
      t.string  :junior_field
      t.string  :text
      t.string  :prefix
      t.string  :suffix
      t.integer :position

      t.timestamps
    end

    Phrase.connection.schema_cache.clear!
    Phrase.reset_column_information

    add_index :phrases, :node_id

    Node.where(type: 'Nodes::Text').each do |node|
      Phrase.create!({
        node: node,
        name: node.name,
        text: node.text,
        prefix: node.prefix,
        suffix: node.suffix,
        junior_field: node.junior_field
      })
    end

    remove_column :nodes, :text
    remove_column :nodes, :prefix
    remove_column :nodes, :suffix
  end

  def down
    add_column :nodes, :text,   :string
    add_column :nodes, :prefix, :string
    add_column :nodes, :suffix, :string

    Phrase.all.each do |phrase|
      phrase.node.name          = phrase.name
      phrase.node.text          = phrase.text
      phrase.node.prefix        = phrase.prefix
      phrase.node.suffix        = phrase.suffix
      phrase.node.junior_field  = phrase.junior_field

      phrase.node.save!
    end

    remove_index :phrases, :node_id

    drop_table :phrases
  end
end
