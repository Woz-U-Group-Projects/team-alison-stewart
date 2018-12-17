module ActiveAdmin
  module Inputs
    module Filters
      class DateRangeInput < ::Formtastic::Inputs::StringInput
        include Base

        def lt_input_name
          "#{method}_lteqdate"
        end
      end
    end
  end
end
