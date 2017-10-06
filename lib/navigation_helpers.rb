module Activate
  module NavigationHelpers
      
    def ul_nav(css_class, items, prefix: '', li_class: '', a_class: '')
      s = ''
      s << %Q{<ul class="#{css_class}">}      
      items.each { |name, path|
        if path.is_a? Array
          s << %Q{<li class="#{li_class} dropdown">}
          s << %Q{<a data-toggle="dropdown" class="#{a_class} dropdown-toggle" href="javascript:;">#{name} <b class="caret"></b></a>}
          s << ul_nav('dropdown-menu', path, prefix: prefix, li_class: li_class, a_class: a_class)
          s << %Q{</li>}
        elsif path.nil?
          s << %Q{<li role="separator" class="divider"></li>}                          
        else
          path = "#{prefix}#{path}" if prefix
          s << %Q{<li}
          s << %Q{ class="active #{li_class}" } if request.path == path
          s << %Q{>}
          s << %Q{<a class="#{a_class}" href="#{path}">#{name}</a>}
          s << %Q{</li>}
        end
      }
      s << %Q{</ul>}
    end
    
  end
end