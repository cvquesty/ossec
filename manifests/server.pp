# OSSEC Server Installer
class ossec::server {

  # Install the main Package
  package { 'ossec-hids':
    ensure => 'installed',
  }

  # Install the Server Component
  package { 'ossec-hids-server':
    ensure => 'installed',
  }
}
