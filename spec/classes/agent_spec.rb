require 'spec_helper'
describe 'ossec::agent' do

  context 'RedHat' do
    # Set facts for RedHat Family Test
    let :facts do
      {
        :concat_basedir => '/foo',
        :os             => { :family => 'RedHat' },
      }
    end

    context "ossec::agent class without any parameters" do
      it { is_expected.to compile.with_all_deps }
      it do
        is_expected.to contain_class('ossec::agent')
      end
    end # End of ossec::agent class

    it do
      is_expected.to contain_package('ossec-hids-agent').with(
        :ensure => 'installed',
      )
    end

    it do
      should compile
    end
  end # End of RedHat Context

  context 'Debian' do
    # Set facts for Debian Family Test
    let :facts do
      {
        :concat_basedir => '/foo',
        :os             => { :family => 'Debian' },
      }
    end

    context "ossec::agent class without any parameters" do
      it { is_expected.to compile.with_all_deps }
      it do
        is_expected.to contain_class('ossec::agent')
      end
    end # End of ossec::agent context

    it do
      is_expected.to contain_package('ossec-hids-agent').with(
        :ensure => 'installed',
      ).that_requires('File[/etc/apt/sources.list.d/atomic.list]')
    end

    it do
      should compile
    end
  end # End of Debian Context
end # End of ossec::agent
