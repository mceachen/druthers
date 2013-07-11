ActiveRecord::Schema.define(:version => 0) do
  create_table :settings, :force => true do |t|
    t.string :key
    t.text :value
    t.timestamps
  end
  add_index :settings, [:key], :unique => true, :name => 'key_udx'
end

class Setting < ActiveRecord::Base
  def_druthers :quest, :favourite_colour, :things, :hashish
  serialize :value

  def self.default_quest
    "to find the holy grail"
  end

  def self.default_things
    [1, 2, 3]
  end

  def validate_favourite_colour
    errors.add(:value, "invalid is invalid WERD") if value == "invalid"
  end
end
