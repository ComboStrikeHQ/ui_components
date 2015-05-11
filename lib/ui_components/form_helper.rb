module UiComponents
  class ValidatedOpenStruct < OpenStruct
    def self.validators_on(*)
      []
    end
  end

  module FormHelper
    def modelless_form(options, &block)
      model_params = options[:params] || params[options[:name]]
      struct = ValidatedOpenStruct.new(model_params)
      bootstrap_form_for(
        struct,
        as: options[:name],
        url: options[:url].to_s,
        method: options.fetch(:method, :post),
        &block
      )
    end
  end
end
