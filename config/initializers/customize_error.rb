module ActionView
  module Helpers
    module Tags
      class Base
        attr_reader :method_name
      end
    end
  end
end

ActionView::Base.field_error_proc = proc do |html_tag, instance|
  if instance.is_a? ActionView::Helpers::Tags::Label
    html_tag
  else
    if html_tag.include? 'class="'
      class_attr_index = html_tag.index 'class="'
      loop do
        html_tag.insert class_attr_index + 7, 'is-invalid '
        class_attr_index = html_tag.index 'class="', class_attr_index + 1
        break if class_attr_index.nil?
      end
    else
      html_tag.insert html_tag.index('>'), " class='is-invalid ' "
    end

    error_messages = "\n<div class=\"invalid-feedback\">"
    error_messages += instance.method_name.humanize + ' '
    instance.object.errors.messages[instance.method_name.to_sym].each do |msg|
      error_messages += msg + ', '
    end
    error_messages.delete_suffix!(', ')
    error_messages += '.</div>'

    last_pos = html_tag.rindex('>') + 1
    html_tag.insert last_pos, error_messages
  end
end