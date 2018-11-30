# OSSEC Repo Installation Manifest
class ossec::repo {

  # Determine the OS we're using
  case $facts['os']['family'] {
    'RedHat': {

      # Import OSSEC key
      exec { 'import_key':
        path    => '/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin',
        command => 'curl -sSL https://ossec.github.io/files/OSSEC-ARCHIVE-KEY.asc | gpg --import -',
      }

      # Determine the Major Release Version and act accordingly
      case $facts['os']['release']['major'] {
        '6': {
          # Install Repo
          package { 'repofile':
            ensure   => 'installed',
            provider => 'rpm',
            source   => 'https://updates.atomicorp.com/channels/atomic/centos/6/i386/RPMS/atomic-release-1.0-21.el6.art.noarch.rpm',
            require  => Exec['import_key'],
          }
        }

        '7': {
          # Install Repo
          package { 'repofile':
            ensure   => 'installed',
            provider => 'rpm',
            source   => 'https://updates.atomicorp.com/channels/atomic/centos/7/x86_64/RPMS/atomic-release-1.0-21.el7.art.noarch.rpm',
            require  => Exec['import_key'],
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
      }

      # Determine the Major Release Version and act accordingly
      case $facts['os']['release']['major'] {
        '14': {
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
        '16': {
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
        '18': {
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
