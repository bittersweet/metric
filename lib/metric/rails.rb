require 'metric/rails/controller_methods'

module Metric
  module Rails
    def self.initialize
      if defined?(ActionController::Base)
        ActionController::Base.send(:include, Metric::Rails::ControllerMethods)
      end
    end
  end
end

Metric::Rails.initialize
