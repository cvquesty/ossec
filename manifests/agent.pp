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
      # Install the OSSEC HIDS Server/Manager
      package { 'ossec-hids':
        ensure => 'installed',
      }

      # Install the OSSEC HIDS Agent
      package { 'ossec-hids-agent':
        ensure => 'installed',
      }
    }

    default: {
      notify ('Your Operating System is Unsupported.')
    }
  }
}
