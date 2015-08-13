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

    def datagrid_filters(form, filters, options = {})
      filter_markup = filters.map do |filter|
        ui_component(:datagrid_filter, options.merge(form: form, filter: filter))
      end

      safe_join filter_markup
    end
  end
end
