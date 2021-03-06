module Jartai
  module AccessControl

    class << self
      def map
        mapper = Mapper.new
        yield mapper
        @permissions ||= []
        @permissions += mapper.mapped_permissions
      end

      def permissions
        @permissions
      end

      # Returns the permission of given name or nil if it wasn't found
      # Argument should be a symbol
      def permission(name)
        permissions.detect {|p| p.name == name}
      end

      # Returns the actions that are allowed by the permission of given name
      def allowed_actions(permission_name)
        perm = permission(permission_name)
        perm ? perm.actions : []
      end

      def public_permissions
        @public_permissions ||= @permissions.select {|p| p.public?}
      end

      def members_only_permissions
        @members_only_permissions ||= @permissions.select {|p| p.require_member?}
      end

      def loggedin_only_permissions
        @loggedin_only_permissions ||= @permissions.select {|p| p.require_loggedin?}
      end

      def available_feature_modules
        @available_feature_modules ||= @permissions.collect(&:feature_module).uniq.compact
      end

      def modules_permissions(modules)
        @permissions.select {|p| p.feature_module.nil? || modules.include?(p.feature_module.to_s)}
      end
    end

    class Mapper
      def initialize
        @feature_module = nil
      end

      def permission(name, hash, options={})
        @permissions ||= []
        options.merge!(:feature_module => @feature_module)
        @permissions << Permission.new(name, hash, options)
      end

      def feature_module(name, options={})
        @feature_module = name
        yield self
        @feature_module = nil
      end

      def mapped_permissions
        @permissions
      end
    end

    class Permission
      attr_reader :name, :actions, :feature_module

      def initialize(name, hash, options)
        @name = name
        @actions = []
        @public = options[:public] || false
        @require = options[:require]
        @feature_module = options[:feature_module]
        hash.each do |controller, actions|
          if actions.is_a? Array
            @actions << actions.collect {|action| "#{controller}/#{action}"}
          else
            @actions << "#{controller}/#{actions}"
          end
        end
        @actions.flatten!
      end

      def public?
        @public
      end

      def require_member?
        @require && @require == :member
      end

      def require_loggedin?
        @require && (@require == :member || @require == :loggedin)
      end
    end
  end
end
