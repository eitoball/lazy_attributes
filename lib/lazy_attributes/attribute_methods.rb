module LazyAttributes
  module AttributeMethods
    def self.included(mod)
      mod.class_eval do
        alias_method :original_attributes, :attributes
        alias_method :attributes, :attributes_with_lazy_attributes
      end
    end

    def attributes_with_lazy_attributes
      self.class._lazy_attributes.each do |attr|
        load_attribute(attr)
      end
      original_attributes
    end
  end
end
