module Stats
  module Assumption
    # If description is registered with global Assumption list,
    # register it on this method. If not, create a new Assumption
    # and register it only to this method.
    def assume(key, &statement)
      method_name = caller.first[/`([^']*)'/, 1] || 'global'
      description = Stats.transform_key(key)
      warning_message = <<-WARNING
[warning] Assumption not met: #{description} in #{method_name}" 
          Test is likely not valid"
      WARNING

      puts warning_message unless statement.call
    end
    
    protected

    def transform_key(camel_case_symbol)
      camel_case_symbol.to_s.gsub('_', ' ')
    end
  end
end
