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

  # adapted from http://stackoverflow.com/a/10786575 instead of using
  # HashWithIndifferentAccess so that I can do this:
  # village.resources['wood'] = 200
  # sacrifice = Sacrifice.on_behalf_of(village).these_goods(wood: 20)  
  def add_default_proc_to_resources
    Proc.new do |hash, key|
      case key
        when String then sym = key.to_sym; hash[sym] if hash.key?(sym)
        when Symbol then str = key.to_s;   hash[str] if hash.key?(str)
      end
    end
  end

  # make sure we serialize consistently and that our resources hash is defined.
  def prep_resource_hash
    self.resources = {} if self.resources.nil?
    self.resources.stringify_keys!
  end
end
