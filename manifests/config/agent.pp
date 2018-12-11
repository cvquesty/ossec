# OSSEC Agent Configuration Manifest
class ossec::config::agent {

  # Backup the Main Config before any configuration work
  exec { 'backup_agent_config':
    path    => '/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin',
    command => 'cp /var/ossec/etc/ossec-agent.conf /var/ossec/etc/ossec-agent.conf-DIST',
    unless  => 'test -f /var/ossec/etc/ossec-agent.conf-DIST',
  }

  # Place Main ossec.conf on disk
  file { '/var/ossec/etc/ossec-agent.conf':
    ensure  => 'present',
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('ossec/agent_config.erb'),
  }

}
