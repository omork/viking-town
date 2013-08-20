require 'active_support/concern'

# there are at least 2 places where resources are stored in the same way.
# Abstract this out.
module Resources
  extend ActiveSupport::Concern

  included do
    serialize :resources
    validate :resources, contains_resources: true
    before_save      :prep_resource_hash
    after_initialize :prep_resource_hash
  end

  # make sure we serialize consistently and that our resources hash is defined.
  def prep_resource_hash
    self.resources = {} if self.resources.nil?
    self.resources.stringify_keys!
  end
end
