module CardconnectSdk
  if ENV['COVERAGE']
    require 'simplecov'

    module_name = name.underscore
    unless SimpleCov.adapters.include?(module_name)
      SimpleCov.adapters.define module_name do
        add_filter 'bin'
        add_filter 'stubs'
        add_filter 'tmp'
        add_filter 'vendor'

        add_group 'Libraries', 'lib'
      end
    end

    SimpleCov.start module_name
  end
end
