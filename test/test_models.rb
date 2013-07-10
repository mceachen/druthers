ActiveRecord::Schema.define(:version => 0) do
  create_table "settings", :force => true do |t|
    t.string "key"
    t.string "value"
    t.timestamps
  end
end

class Setting < ActiveRecord::Base
  acts_as_settings
end
