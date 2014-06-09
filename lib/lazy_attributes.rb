module LazyAttributes
  module Base
    extend ActiveSupport::Concern

    included do
      class_attribute :_lazy_attributes, instance_writer: false
      self._lazy_attributes = []
    end

    def load_attribute(attr)
      unless has_attribute?(attr)
        write_attribute(attr, nil)
        write_attribute(attr, self.class.where(id: self.id).select(attr).first.send(attr))
      end
    end

    module ClassMethods
      def lazy_attributes(*attrs)
        if self._lazy_attributes.empty?
          default_scope do
            select(column_names_without_lazy.map do |column_name|
              "#{table_name}.#{column_name}"
            end)
          end
        end
        attrs = attrs.map(&:to_s)
        attrs.each do |attr|
          attr = attr.to_sym
          define_method(attr) do
            load_attribute(attr)
            read_attribute(attr)
          end
          define_method(:"#{attr}=") do |val|
            load_attribute(attr)
            write_attribute(attr, val)
          end
        end
        self._lazy_attributes += attrs
      end

      def column_names_without_lazy
        column_names - self._lazy_attributes
      end

      def column_symbols_without_lazy
        column_names_without_lazy.map(&:to_sym)
      end
    end
  end
end

require_relative 'lazy_attributes/relation'

ActiveSupport.on_load :active_record do
  ActiveRecord::Base.send(:include, LazyAttributes::Base)
  ActiveRecord::Relation.send(:include, LazyAttributes::Relation)
end
