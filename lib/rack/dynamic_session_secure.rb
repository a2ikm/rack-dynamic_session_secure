require "rack/dynamic_session_secure/version"

module Rack
  module DynamicSessionSecure
  end

  module Session
    module Abstract
      class ID
        def prepare_session_with_dynamic(env)
          prepare_session_without_dynamic(env)

          _options = env[ENV_SESSION_OPTIONS_KEY].dup

          secure = _options[:secure]
          if secure && secure.respond_to?(:call)
            _options[:secure] = !!secure.call(env)
          end

          env[ENV_SESSION_OPTIONS_KEY] = _options
        end

        alias_method :prepare_session_without_dynamic, :prepare_session
        alias_method :prepare_session, :prepare_session_with_dynamic
      end
    end
  end
end
