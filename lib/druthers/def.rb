require 'druthers/support'

module Druthers
  VALID_METHOD_NAME = /\A\w+\z/
  module Def
    def def_druthers(*keys)
      include Support
      keys.each do |ea|
        fail "setting keys must be alphanumeric" unless ea.to_s =~ Druthers::VALID_METHOD_NAME
        class_eval <<-RUBY, __FILE__, __LINE__ + 1
          def self.#{ea}=(value)
            self.set_druther(:#{ea}, value)
          end
          def self.#{ea}
            get_druther(:#{ea})
          end
        RUBY
      end
    end
  end
end
