# OSSEC Agent Installer
class ossec::agent {

  # Choose packages based on OS
  case $facts['os']['name'] {
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

    'Ubuntu': {

    }

    default: {
    }
  }
}
