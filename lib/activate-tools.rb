require 'padrino'
require 'param_helpers'
require 'navigation_helpers'

module ActivateTools
  extend Padrino::Module
  gem! "activate-tools"
end

String.send(:define_method, :html_safe?){ true }