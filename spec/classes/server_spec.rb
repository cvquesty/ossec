require 'spec_helper'
describe 'ossec::server' do

  # Add in ossec::repo to get the file resource we're testing for on the require
  let(:pre_condition) { 'include ossec::repo' }

  context 'RedHat' do
    # Set facts for RedHat Family Test
    let :facts do
      {
        concat_basedir: '/foo',
        os:             { family: 'RedHat', release: { major: '6' } },
      }
    end

    context 'ossec::server class without any parameters' do
      it { is_expected.to compile.with_all_deps }
      it do
        is_expected.to contain_class('ossec::server')
      end
    end # End of ossec::server class

    it do
      is_expected.to contain_package('ossec-hids-server').with(
        ensure: 'installed',
      )
    end
  end # End of RedHat Context

  context 'Debian' do
    # Set facts for Debian Family Test
    let :facts do
      {
        concat_basedir:  '/foo',
        os:              { family: 'Debian', release: { major: '14.04' } },
      }
    end

    context 'ossec::server class without any parameters' do
      it { is_expected.to compile.with_all_deps }
      it do
        is_expected.to contain_class('ossec::server')
      end
    end # End of ossec::server context

    it do
      is_expected.to contain_package('ossec-hids-server').with(
        ensure: 'installed',
      ).that_requires('File[/etc/apt/sources.list.d/atomic.list]')
    end
  end # End of Debian Context
end # End of ossec::server
