ActiveRecord::Schema.define(:version => 0) do
  create_table :settings, :force => true do |t|
    t.string :key
    t.text :value
    t.timestamps
  end
  add_index :settings, [:key], :unique => true, :name => 'key_udx'
end

class Setting < ActiveRecord::Base
  def_druthers :quest, :favourite_colour, :things, :hashish, :change

  def self.default_quest
    "to find the holy grail"
  end

  def self.default_things
    [1, 2, 3]
  end

  def validate_favourite_colour
    errors.add(:value, "invalid is invalid WERD") if value == "invalid"
  end

  class CustomSerialize
    def self.load(val)
      ActiveRecord::Coders::YAMLColumn.new.load(val)
    end

    def self.dump(val)
      val = 'bar' if val == 'foo'
      ActiveRecord::Coders::YAMLColumn.new.dump(val)
    end
  end

  serialize :value, CustomSerialize

end
