module Activate
  module NavigationHelpers

    def ul_nav(items, prefix: '', ul_class: 'navbar-nav', li_class: 'nav-item', a_class: 'nav-link')
      s = ''
      s << %Q{<ul class="#{ul_class}">}      
      items.each { |name, path|
        if path.is_a? Array
          s << %Q{<li class="#{li_class} dropdown">}
          s << %Q{<a data-toggle="dropdown" class="#{a_class} dropdown-toggle" href="javascript:;">#{name} <b class="caret"></b></a>}
          s << ul_nav(path, prefix: prefix, ul_class: 'dropdown-menu', li_class: li_class, a_class: 'dropdown-item')
          s << %Q{</li>}
        elsif path.nil?
          s << %Q{<li role="separator" class="divider"></li>}                          
        else
          path = "#{prefix}#{path}" if prefix
          s << %Q{<li}
          s << %Q{ class="#{li_class}" }
          s << %Q{>}
          s << %Q{<a class="#{'active' if request.path == path} #{a_class}" href="#{path}">#{name}</a>}
          s << %Q{</li>}
        end
      }
      s << %Q{</ul>}
    end  
    
  end
end