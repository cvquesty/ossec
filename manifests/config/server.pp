# OSSEC Server Configuration Manifest
class ossec::config::server {

  # Backup the Main Config before any configuration work
  exec { 'backup_server_config':
    path    => '/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin',
    command => 'cp /var/ossec/etc/ossec.conf /var/ossec/etc/ossec.conf-DIST',
    unless  => 'test -f /var/ossec/etc/ossec.conf-DIST',
  }


  # Place Main ossec.conf on disk
  file { '/var/ossec/etc/ossec-server.conf':
    ensure  => 'present',
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('ossec/server_config.erb'),
  }

}
