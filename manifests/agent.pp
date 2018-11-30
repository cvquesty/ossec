# OSSEC Agent Installer
class ossec::agent {

  # Choose packages based on OS
  case $facts['os']['family'] {
    'RedHat': {
      # Install the main Package
      package { 'ossec-hids':
        ensure => 'installed',
      }

      # Install the Server Component
      package { 'ossec-hids-client':
        ensure => 'installed',
      }
    }

    'Debian': {
      # Install the OSSEC HIDS Agent
      package { 'ossec-hids-agent':
        ensure  => 'installed',
        require => File['/etc/apt/sources.list.d/atomic.list'],
      }
    }

    default: {
      notice ('Your Operating System is Unsupported.')
    }
  }
}
