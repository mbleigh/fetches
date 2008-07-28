module ActionController
  module Fetches
    def self.included(base)
      base.class_eval do
        @@default_fetcher_options = { :using => "find",
                                      :from => :id }
        cattr_accessor :default_fetcher_options
        
        def self.fetchers
          read_inheritable_attribute(:fetchers) || write_inheritable_attribute(:fetchers, {})
        end

        # Automatically creates a helper method to fetch a memoized record based on
        # a passed-in parameter.
        #
        # Usage:
        #
        #   class UsersController < ApplicationController
        #     fetches :user
        #   end
        #
        #   # Advanced example with nested route such as /users/:user_id/articles
        #   class ArticlesController < ApplicationController
        #     fetches :user, :as => :author, :from => :user_id, :using => :find_by_login
        #     fetches :article
        #   end
        #
        #  # Example with Proc-based 'from'
        #  class UsersController < ApplicationController
        #    fetches :user, :from => Proc.new{ |c| c.params[:user_id] || c.params[:id] }
        #  end
        #
        # Options:
        #
        # - +as+: the name of the helper method to generate (default is the model name)
        # - +from+: the parameter passed into the finder method (default is +:id+). 
        #     May also be passed as a +Proc+ that evaluates against a controller argument.
        # - +using+: the class method name to use as a finder (default is +"find"+)
        #
        # Default options may be specified by setting them in an initializer. Example:
        #
        #    ActionController::Base.default_fetcher_options[:using] = "find_by_id"
        def self.fetches(model_name, options = {})
          method_name = options.delete(:as) || default_fetcher_options[:as] || model_name.to_s
          finder = options.delete(:using) || default_fetcher_options[:using]
          from = options.delete(:from) || default_fetcher_options[:from]
          klass = self.respond_to?(:class_eval) ? self : self.metaclass
          fetchers[method_name.to_sym] = from
          
          klass.class_eval <<-EOS, __FILE__, __LINE__
            def #{method_name}
              if defined?(@#{method_name})
                @#{method_name}
              else
                fetcher = self.class.fetchers[:#{method_name}]
                from = fetcher.is_a?(Proc) ? fetcher.call(self) : params[fetcher]
                @#{method_name} = #{model_name.to_s.classify}.#{finder.to_s}(from)
              end
            end
          EOS
          helper_method method_name
        end
      end
    end
  end
end