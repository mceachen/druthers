require 'active_support/concern'
module Druthers
  module Support
    extend ActiveSupport::Concern

    included do
      validate :validate_druthers
    end

    def validate_druthers
      sym = "validate_#{key}".to_sym
      send(sym) if respond_to?(sym)
    end

    module ClassMethods
      # This can be overridden by the consumer
      def druthers_cache
        @druthers_cache ||= ActiveSupport::Cache::MemoryStore.new(expires_in: 10.minutes)
      end

      # Directly access the setting with the given key name.
      # Note that overriding this method shouldn't be done directly.
      # Use one of the event methods instead.
      def get_druther(key)
        druthers_cache.fetch(key) do
          val = where(key: key).pluck(:value).to_a
          val.present? ? val.first : send_druthers_event(:default, key)
        end
      end

      def set_druther(key, value)
        obj = where(key: key).first_or_initialize
        obj.update!(value: value)
        # Only update the cache if the update! succeeded:
        druthers_cache.write(key, value)
        obj
      end

      def send_druthers_event(event_name, key)
        sym = "#{event_name}_#{key}".to_sym
        send(sym) if respond_to?(sym)
      end
    end
  end
end
