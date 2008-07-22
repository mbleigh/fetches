require 'action_controller/fetches'

ActionController::Base.send :include, ActionController::Fetches
RAILS_DEFAULT_LOGGER.info("** Fetches: initialized properly")