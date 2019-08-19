# para mostar "validaciones" de cosas que estan bien

# module ActionView
#   class Base
#     cattr_accessor :field_okay_proc
#
#   end
#
#   module Helpers
#     module ActiveModelInstanceTag
#       def error_wrapping(html_tag)
#         if object_has_errors?
#           Base.field_error_proc.call(html_tag, self)
#         else
#           Base.field_okay_proc.call(html_tag, self)
#         end
#       end
#     end
#   end
# end

ActionView::Base.field_error_proc = proc do |html_tag, instance|
  if instance.is_a? ActionView::Helpers::Tags::Label
    html_tag
  else
    class_attr_index = html_tag.index 'class="'

    if class_attr_index
      html_tag.insert class_attr_index + 7, 'is-invalid '
    else
      html_tag.insert html_tag.index('>'), " class='is-invalid ' "
    end

    error_messages = "\n<div class=\"invalid-feedback\">"
    instance.object.errors.full_messages.each do |msg|
      error_messages += msg + ', '
    end
    error_messages.delete_suffix!(', ')
    error_messages += '</div>'

    last_pos = html_tag.index('>') + 1
    html_tag.insert last_pos, error_messages
  end
end

# mostrar validaciones que estan bien?

# ActionView::Base.field_okay_proc = proc do |html_tag, _instance|
#   class_attr_index = html_tag.index 'class="'
#
#   if class_attr_index
#     html_tag.insert class_attr_index + 7, 'is-valid '
#   else
#     html_tag.insert html_tag.index('>'), " class='is-valid ' "
#   end
# end