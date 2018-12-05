require 'spec_helper'
describe 'ossec' do

  context 'RedHat6' do
    let :facts do
      {
        :concat_basedir => '/foo',
        :os             => { :family => 'RedHat', :release => { :major => '6' } },
      }
    end

    context "ossec Class without any parameters" do
      it { is_expected.to compile.with_all_deps }
      it do
        is_expected.to contain_class('ossec')
        is_expected.to contain_class('ossec::repo')
      end

      it do
        should compile
      end
    end # End of ossec class context
  end  # End of RedHat 6 context

  context 'RedHat7' do
    let :facts do
      {
        :concat_basedir => '/foo',
        :os             => { :family => 'RedHat', :release => { :major => '7' } },
      }
    end

    context "ossec Class without any parameters" do
      it { is_expected.to compile.with_all_deps }
      it do
        is_expected.to contain_class('ossec')
        is_expected.to contain_class('ossec::repo')
      end

      it do
        should compile
      end
    end # End of ossec class context
  end # End of RedHat 7 context

  context 'Ubuntu14.04' do
    let :facts do
      {
        :concat_basedir => '/foo',
        :os             => { :family => 'Debian', :release => { :major => '14' } },
      }
    end

    context "ossec Class without any parameters" do
      it { is_expected.to compile.with_all_deps }
      it do
        is_expected.to contain_class('ossec')
        is_expected.to contain_class('ossec::repo')
      end

      it do
        should compile
      end
    end # End of ossec class context
  end # End Ubuntu14.04 Context

  context 'Ubuntu16.04' do
    let :facts do
      {
        :concat_basedir => '/foo',
        :os             => { :family => 'Debian', :release => { :major => '16' } },
      }
    end

    context "ossec Class without any parameters" do
      it { is_expected.to compile.with_all_deps }
      it do
        is_expected.to contain_class('ossec')
        is_expected.to contain_class('ossec::repo')
      end

      it do
        should compile
      end
    end # End of ossec class context
  end # End Ubuntu 16.04 Context

  context 'Ubuntu 18.04' do
    let :facts do
      {
        :concat_bassedir => '/foo',
        :os              => { :family => 'Debian', :release => { :major => '18' } },
      }
    end

    context "ossec Classs without any parameters" do
      it { is_expected.to compile.with_all_deps }
      it do
        is_expected.to contain_class('ossec')
        is_expected.to contain_class('ossec::repo')
      end
    end # End of ossec class context
  end # End Ubuntu 18.04 Context
end # End of ossec describe