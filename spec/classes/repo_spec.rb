require 'spec_helper'
describe 'ossec::repo' do

  context 'RedHat' do
    # Set facts for RedHat Family Test
    let :facts do
      {
        concat_basedir: '/foo',
        os:             { family: 'RedHat', release: { major: '6' } },
      }
    end

    context 'ossec::repo class without any parameters' do
      it { is_expected.to compile.with_all_deps }
      it do
        is_expected.to contain_class('ossec::repo')
      end
    end # End ossec::repo class

    it do
      is_expected.to contain_exec('import_key').with(
        path:    '/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin',
        command: 'curl -sSL https://ossec.github.io/files/OSSEC-ARCHIVE-KEY.asc | gpg --import -',
        unless:  'gpg --list-keys | grep uid | awk {\'print $5\'} | tr -d \'<>\' | grep "scott@atomicorp.com"',
      )
    end

    it do
      is_expected.to contain_package('ossec-hids').with(
        ensure: 'present',
      )
    end

    it do
      is_expected.to contain_exec('install_rhel6_repo').with(
        path:    '/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin',
        command: 'rpm -i https://updates.atomicorp.com/channels/atomic/centos/6/i386/RPMS/atomic-release-1.0-21.el6.art.noarch.rpm',
        unless:  'test -f /etc/yum.repos.d/atomic.repo',
      ).that_requires('Exec[import_key]')
    end
  end # End of RedHat Context

  context 'Debian' do
    # Set facts for Debian Family Test
    let :facts do
      {
        concat_basedir: '/foo',
        os:             { family: 'Debian', release: { major: '14.04' } },
      }
    end

    context 'ossec::repo class without any parameters' do
      it { is_expected.to compile.with_all_deps }
      it do
        is_expected.to contain_class('ossec::repo')
      end
    end # End ossec::repo class

    it do
      is_expected.to contain_exec('import_key').with(
        path:    '/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin',
        command: 'wget -q -O - https://www.atomicorp.com/RPM-GPG-KEY.atomicorp.txt  | sudo apt-key add -',
        unless:  'apt-key list | grep Atomicorp | awk {\'print $7\'} | tr -d \'<>\' | grep "support@atomicorp.com"',
      )
    end

    it do
      is_expected.to contain_file('/etc/apt/sources.list.d/atomic.list').with(
        ensure:  'present',
        owner:   'root',
        group:   'root',
        mode:    '0644',
        content: 'deb https://updates.atomicorp.com/channels/atomic/ubuntu trusty main',
      ).that_notifies('Exec[update_repos]'
      ).that_requires('Exec[import_key]')
    end

    it do
      is_expected.to contain_exec('update_repos').with(
        path:    '/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin',
        command: 'apt-get update',
      )
    end
  end # End of Debian Context
end # End of ossec::repo
