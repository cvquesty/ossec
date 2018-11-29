# OSSEC Server Installer
class ossec::server {

  # Since the OSSEC repos are in place first, all platforms can call on
  # Ossec via the package resource. In this way, no extra conditionals
  # or case statements are necessary before asserting the server install

  # Install the main Package
  package { 'ossec-hids':
    ensure => 'installed',
  }

  # Install the Server Component
  package { 'ossec-hids-server':
    ensure => 'installed',
  }
}
