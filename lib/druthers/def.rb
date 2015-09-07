require 'druthers/support'

module Druthers
  VALID_METHOD_NAME = /\A\w+\z/
  module Def
    def def_druthers(*keys)
      include Support
      keys.each do |ea|
        fail 'key names must be alphanumeric' unless ea.to_s =~ Druthers::VALID_METHOD_NAME
        class_eval <<-RUBY, __FILE__, __LINE__ + 1
          def self.#{ea}=(value)
            self.set_druther(:#{ea}, value)
          end unless respond_to?(:#{ea}=)
          def self.#{ea}
            get_druther(:#{ea})
          end unless respond_to?(:#{ea})
        RUBY
      end
    end
  end
end
