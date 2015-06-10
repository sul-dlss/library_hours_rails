FactoryGirl.define do
  factory :user do
    id 'normal-user'
  end

  factory :superadmin_user, class: User do
    id 'test-super-admin'
    ldap_group_string 'super-admin'
  end

  factory :site_admin_user, class: User do
    id 'test-admin'
    ldap_group_string 'site-admin'
  end
end
