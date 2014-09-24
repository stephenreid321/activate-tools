module Activate
  module NavigationHelpers
      
    def ul_nav(css_class, items, prefix: '')
      s = ''
      s << %Q{<ul class="#{css_class}">}      
      items.each { |name, path, icon|
        icon = %Q{<i class="#{icon}"></i>} if icon
        if path.is_a? Array
          s << %Q{<li class="dropdown">}
          s << %Q{<a data-toggle="dropdown" class="dropdown-toggle" href="javascript:;">#{icon} #{name} <b class="caret"></b></a>}
          s << ul_nav('dropdown-menu', path)
          s << %Q{</li>}
        else
          s << %Q{<li}
          s << %Q{ class="active" } if request.path == path
          s << %Q{>}
          s << %Q{<a href="#{path}">#{icon} #{name}</a>}
          s << %Q{</li>}
        end
      }
      s << %Q{</ul>}
    end
    
  end
end