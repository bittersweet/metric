module Metric
  module Rails
    module ControllerMethods
      def track_metric(metric, options = {})
        options[:customer] ||= metric_current_user
        Metric.track(metric, options)
      end

      def metric_current_user
        user = current_user
        return {} if current_user.nil?

        parameters = {}
        [:id, :name, :username, :email].each do |attribute|
          parameters[attribute.to_s] = user.send(attribute) if user.respond_to?(attribute)
        end
        parameters
      rescue NoMethodError, NameError
        {}
      end
    end
  end
end
