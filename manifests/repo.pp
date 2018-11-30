# OSSEC Repo Installation Manifest
class ossec::repo {

  # Determine the OS we're using
  case $facts['os']['family'] {
    'RedHat': {

      # Import OSSEC key
      exec { 'import_key':
        path    => '/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin',
        command => 'curl -sSL https://ossec.github.io/files/OSSEC-ARCHIVE-KEY.asc | gpg --import -',
        unless  => 'gpg --list-keys | grep uid | awk {\'print $5\'} | tr -d \'<>\' | grep "scott@atomicorp.com"',
      }

      ############################################################################################
      # For RedHat, the ossec-hids package is needed regardless of whether you are using -server #
      # or -agent. As such, I can't put the ossec-hids into both or Puppet will barf.  Instead,  #
      # I will place it here with the understanding that it is required /regardless/. "Repo"     #
      # isn't my preferred place for it, and it may move in the future.                          #
      ############################################################################################
      package { 'ossec-hids':
        ensure => 'present',
      }

      # Determine the Major Release Version and act accordingly
      case $facts['os']['release']['major'] {
        '6': {
          # Install Repo
          exec { 'install_rhel6_repo':
            path    => '/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin',
            command => 'rpm -i https://updates.atomicorp.com/channels/atomic/centos/6/i386/RPMS/atomic-release-1.0-21.el6.art.noarch.rpm',
            unless  => 'test -f /etc/yum.repos.d/atomic.repo',
            require => Exec['import_key']
          }
        }

        '7': {
          # Install Repo
          exec { 'install_rhel7_repo':
            path    => '/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin',
            command => 'rpm -i https://updates.atomicorp.com/channels/atomic/centos/7/x86_64/RPMS/atomic-release-1.0-21.el7.art.noarch.rpm',
            unless  => 'test -f /etc/yum.repos.d/atomic.repo',
            require => Exec['import_key']
          }
        }
        default: {
          notice ('Error. Your OS Major Release Version is Unsupported.')
        }
      }
    }

    'Debian': {

      # Import OSSEC Key
      exec { 'import_key':
        path    => '/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin',
        command => 'wget -q -O - https://www.atomicorp.com/RPM-GPG-KEY.atomicorp.txt  | sudo apt-key add -',
        unless  => 'gpg --list-keys | grep uid | awk {\'print $5\'} | tr -d \'<>\' | grep "scott@atomicorp.com"',
      }

      # Determine the Major Release Version and act accordingly
      case $facts['os']['release']['major'] {
        '14.04': {
          # Add APT Source to configuration
          file { '/etc/apt/sources.list.d/atomic.list':
            ensure  => 'present',
            owner   => 'root',
            group   => 'root',
            mode    => '0644',
            content => 'deb https://updates.atomicorp.com/channels/atomic/ubuntu trusty main',
            notify  => Exec['update_repos'],
            require => Exec['import_key'],
          }
        }
        '16.04': {
          # Add APT Source to configuration
          file { '/etc/apt/sources.list.d/atomic.list':
            ensure  => 'present',
            owner   => 'root',
            group   => 'root',
            mode    => '0644',
            content => 'deb https://updates.atomicorp.com/channels/atomic/ubuntu xenial main',
            notify  => Exec['update_repos'],
            require => Exec['import_key'],
          }
        }
        '18.04': {
          # Add APT Source to configuration
          file { '/etc/apt/sources.list.d/atomic.list':
            ensure  => 'present',
            owner   => 'root',
            group   => 'root',
            mode    => '0644',
            content => 'deb https://updates.atomicorp.com/channels/atomic/ubuntu bionic main',
            notify  => Exec['update_repos'],
            require => Exec['import_key'],
          }
        }
        default: {
          notice ('Error. Your OS Major Release Version is Unsupported.')
        }
      }

        # Refresh the Ubuntu APT Repos
        exec { 'update_repos':
          path    => '/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin',
          command => 'apt-get update'
        }

    }
    default: {
      notice ('Error. Your Operating System is Unsupported.')
    }
  }
}
