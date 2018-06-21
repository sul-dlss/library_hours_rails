require 'rails_helper'

describe User do
  describe '.from_env' do
    subject { User.from_env('REMOTE_USER' => 'jstanford', 'WEBAUTH_LDAPPRIVGROUP' => 'admin|user') }
    it 'extracts user information from the given environment' do
      expect(subject.id).to eq 'jstanford'
    end

    it 'extracts privgroup membership from the given environment' do
      expect(subject.ldap_groups).to match_array %w(admin user)
    end
  end

  describe '.from_env from shibboleth' do
    subject { User.from_env('REMOTE_USER' => 'jstanford', 'eduPersonEntitlement' => 'admin;user') }
    it 'extracts user information from the given environment' do
      expect(subject.id).to eq 'jstanford'
    end

    it 'extracts privgroup membership from the given environment' do
      expect(subject.ldap_groups).to match_array %w(admin user)
    end
  end


  describe '#superadmin?' do
    it 'is a superadmin' do
      expect(build(:superadmin_user)).to be_superadmin
      expect(build(:site_admin_user)).not_to be_superadmin
      expect(build(:user)).not_to be_superadmin
    end
  end

  describe '#site_admin?' do
    it 'is a site admin' do
      expect(build(:superadmin_user)).to be_site_admin
      expect(build(:site_admin_user)).to be_site_admin
      expect(build(:user)).not_to be_site_admin
    end
  end
end
