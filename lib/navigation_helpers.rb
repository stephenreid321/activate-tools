module Activate
  module NavigationHelpers

    def ul_nav(items,
        prefix: '',
        ul_class: 'navbar-nav',
        li_class: 'nav-item',
        a_class: 'nav-link',
        ul_id: '',
        subnav_li_class: 'nav-item dropdown',
        subnav_data_toggle: 'dropdown',                
        subnav_a_class: 'nav-link dropdown-toggle',
        subnav_href: 'javascript:;',
        subnav_caret: '<b class="caret"></b>',
        subnav_ul_class: 'dropdown-menu',
        subnav_ul_id: '',
        subnav_li2_class: 'nav-item',
        subnav_a2_class: 'dropdown-item',
        generate_subnav_href_and_ul: false
      )
      s = ''
      s << %Q{<ul class="#{ul_class}" id="#{ul_id}">}      
      items.each { |name, path|
        if path.is_a? Array
          if generate_subnav_href_and_ul
            uuid = SecureRandom.uuid
            subnav_href = "##{uuid}"
            subnav_ul_id = uuid
          end
          s << %Q{<li class="#{subnav_li_class}">}
          s << %Q{<a data-toggle="#{subnav_data_toggle}" class="#{subnav_a_class}" href="#{subnav_href}">#{name}#{subnav_caret}</a>}
          s << ul_nav(path, prefix: prefix, ul_class: subnav_ul_class, ul_id: subnav_ul_id, li_class: subnav_li2_class, a_class: subnav_a2_class)
          s << %Q{</li>}
        elsif path.nil?
          s << %Q{<li class="dropdown-divider"></li>}                          
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