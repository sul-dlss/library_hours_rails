FactoryGirl.define do
  factory :superadmin_user, class: User do
    id 'test-user'
    ldap_group_string 'super-admin'
  end
end
