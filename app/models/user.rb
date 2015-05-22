class User
  include ActiveModel::Model
  attr_accessor :uid, :ldap_group_string

  def self.from_env(env)
    return unless env['REMOTE_USER']

    User.new(uid: env['REMOTE_USER'], ldap_group_string: env['WEBAUTH_LDAPPRIVGROUP'])
  end

  def superadmin?
    admin_groups = Settings.super_admin_groups || []
    (ldap_groups & admin_groups).present?
  end

  def site_admin?
    admin_groups = Settings.site_admin_groups || []
    (ldap_groups & admin_groups).present?
  end

  def ldap_groups
    (@ldap_group_string || '').split('|')
  end
end
