# OSSEC Server Installer
class ossec::server {
  case $facts['os']['family'] {
    'RedHat': {

      # Install the OSSEC HIDS Manager
      package { 'ossec-hids':
        ensure  => 'installed',
        require => Class['ossec::repo'],
      }

      # Install the OSSEC HIDS Server
      package { 'ossec-hids-server':
        ensure  => 'installed',
        require => Class['ossec::repo'],
      }
    }
    'Debian': {
      # Install the OSSEC HIDS Server/Manager
      package { 'ossec-hids':
        ensure  => 'installed',
        require => Class['ossec::repo'],
      }
    }
    default: {
      notify ('Error. Your OS is Unsupported.')
    }
  }
}
