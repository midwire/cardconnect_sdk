module CardconnectSdk
  module Helpers
    module Response
      RESPSTAT_APPROVED = 'A'
      RESPSTAT_RETRY    = 'B'
      RESPSTAT_DECLINED = 'C'

      module ClassMethods
      end

      module InstanceMethods
        def approved?
          respstat == RESPSTAT_APPROVED
        end

        def retry?
          respstat == RESPSTAT_RETRY
        end

        def declined?
          respstat == RESPSTAT_DECLINED
        end
      end

      def self.included base
        base.send :include, InstanceMethods
        base.extend ClassMethods
      end
    end
  end
end
