module Activate
  module ParamHelpers

    def fix_params!
      datetime_hashes_to_datetimes!(params)      
      date_hashes_to_dates!(params)      
      file_hashes_to_files!(params)
      coordinate_hashes_to_coordinates!(params)              
      blanks_to_nils!(params)    
      fix_pages!(params)  
    end
            
    def datetime_hashes_to_datetimes!(hash)
      hash.each { |k,v|
        if v.is_a?(Hash) and [:year, :month, :day, :hour, :min].all? { |x| v.has_key?(x.to_s) }
          hash[k] = begin; Time.zone.parse("#{v[:day]}-#{v[:month]}-#{v[:year]} #{v[:hour]}:#{v[:min]}"); rescue; nil; end
        elsif v.is_a?(Hash)
          datetime_hashes_to_datetimes!(v)
        end
      }
    end
    
    def date_hashes_to_dates!(hash)
      hash.each { |k,v|
        if v.is_a?(Hash) and [:year, :month, :day].all? { |x| v.has_key?(x.to_s) }
          hash[k] = begin; Date.parse("#{v[:day]}-#{v[:month]}-#{v[:year]}"); rescue; nil; end
        elsif v.is_a?(Hash)
          date_hashes_to_dates!(v)
        end
      }
    end
    
    def file_hashes_to_files!(hash)
      hash.each { |k, v|
        if v.is_a?(Hash) and v[:tempfile]
          tempfile = v[:tempfile]
          tempfile.original_filename = v[:filename]
          hash[k] = tempfile
        elsif v.is_a?(Hash)
          file_hashes_to_files!(v)
        end
      }
    end
    
    def coordinate_hashes_to_coordinates!(hash)
      hash.each { |k,v|
        if v.is_a?(Hash) and [:lat, :lng].all? { |x| v.has_key?(x.to_s) }
          if [v[:lng].to_f, v[:lat].to_f] == [0.0,0.0]
            hash[k] = nil
          else
            hash[k] = [v[:lng].to_f, v[:lat].to_f]
          end
        elsif v.is_a?(Hash)
          coordinate_hashes_to_coordinates!(v)
        end
      }
    end    
  
    def blanks_to_nils!(hash)   
      hash.each { |k,v|
        if v.blank?
          hash[k] = nil
        elsif v.is_a? Array
          v.each_with_index { |x,i| v[i] = nil if x.blank? }.compact!
        elsif v.is_a? Hash
          blanks_to_nils!(v)
        end
      }
    end

    def fix_pages!(hash)
      hash.each do |k, v|
        if (k == 'page' || k.ends_with?('_page')) && v.is_a?(String)
          hash[k] = v.to_i == 0 ? 1 : v.to_i
        end
      end
    end     

  end
end

class Tempfile  
  attr_accessor :original_filename
end