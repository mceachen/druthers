require 'active_support'
require 'active_record'

ActiveSupport.on_load :active_record do
  require 'druthers/def'
  ActiveRecord::Base.send :extend, Druthers::Def
end
