# frozen_string_literal: true

class User
  include ActiveModel::Model
  attr_accessor :id, :ldap_groups

  def self.from_env(env)
    return unless env['REMOTE_USER'].present?

    ldap_groups = env['eduPersonEntitlement']&.split(';') || []
    User.new(id: env['REMOTE_USER'], ldap_groups: ldap_groups)
  end

  def superadmin?
    admin_groups = Settings.super_admin_groups || []
    (ldap_groups & admin_groups).present?
  end

  def site_admin?
    admin_groups = Settings.site_admin_groups || []
    superadmin? || (ldap_groups & admin_groups).present?
  end
end
