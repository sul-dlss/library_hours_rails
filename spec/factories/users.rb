# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    id 'normal-user'
  end

  factory :superadmin_user, class: User do
    id 'test-super-admin'
    ldap_groups ['super-admin']
  end

  factory :site_admin_user, class: User do
    id 'test-admin'
    ldap_groups ['site-admin']
  end
end
