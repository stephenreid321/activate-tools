module Activate
  module DatetimeHelpers
     
    def date_select_tags(name, options={})
      value = options[:value]
      disabled = options[:disabled] || false
      required = options[:required] || false
      # options[:class]
      s = []
      s << '<span class="date">'
      s << text_field_tag(:"#{name}[day]", :class => options[:class], :value => (value.day if value), :disabled => disabled, :required => required)
      s << select_tag(:"#{name}[month]", :options => [nil] + Date::MONTHNAMES[1..-1].each_with_index.map { |x,i| ["#{x}","#{i+1}"] }, :class => options[:class], :selected => (value.month if value), :disabled => disabled, :required => required)
      s << text_field_tag(:"#{name}[year]", :class => options[:class], :value => (value.year if value), :disabled => disabled, :required => required)
      s << '</span>'
      s.join(' ')        
    end
    
    def datetime_select_tags(name, options={})      
      value = options[:value]
      disabled = options[:disabled] || false
      required = options[:required] || false
      # options[:class]
      # options[:fives]
      s = []
      s << '<span class="time"> @ '
      s << select_tag(:"#{name}[hour]", :options => [nil] + 0.upto(23).map { |x| [x < 10 ? "0#{x}" : "#{x}","#{x}"] }, :class => options[:class], :selected => (value.hour if value), :disabled => disabled, :required => required) 
      s << ':'
      s << select_tag(:"#{name}[min]", :options =>
          [nil] + (options[:fives] ? 0.upto(11).map { |x| x*5 } : 0.upto(59) ).map { |x| [x < 10 ? "0#{x}" : "#{x}","#{x}"] },
        :class => options[:class], :selected => (value.min if value), :disabled => disabled, :required => required)
      s << '</span>'
      s.join(' ')      
      [date_select_tags(name, options), s].join(' ')
    end       
    
    def compact_time_ago(t)
      d = Time.now - t
      if d < 1.day
        time_ago_in_words(t) + ' ago'
      elsif d < 3.days
        t.strftime('%A') + " at #{t.to_s(:time)}"
      else
        t
      end
    end
    
  end
end